;;; packages.el --- codeium layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2024 Sylvain Benner & Contributors
;;
;; Author:  <choug@UM780>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `codeium-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `codeium/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `codeium/pre-init-PACKAGE' and/or
;;   `codeium/post-init-PACKAGE' to customize the package as it is loaded.


;; https://github.com/Exafunction/codeium.el?tab=readme-ov-file#-installation-options

;;; Code:
(defconst codeium-packages
  '((codeium :location (recipe
                        :fetcher github
                        :repo "Exafunction/codeium.el"))
    )
  )

(defun codeium/init-codeium ()
  (use-package codeium
    :init
    ;; 全局配置
    (add-to-list 'completion-at-point-functions #'codeium-completion-at-point)
    ;; 或者靠hook只在某个特定mode下生效
    ;; (add-hook 'python-mode-hook
    ;;           (lambda ()
    ;;             (setq-local completion-at-point-functions '(
    ;;                                                         codeium-completion-at-point
    ;;                                                         ))))
    :config
    ;; 不显示dialog
    (setq use-dialog-box nil)

    ;; 允许使用codeium-diagnose来显示和codeium的通信
    (setq codeium-api-enabled
          (lambda (api)
            (memq api '(GetCompletions Heartbeat CancelRequest GetAuthToken RegisterUser auth-redirect AcceptCompletion))))

    ;; 也可以针对某个特定的mode配置一些变量
    ;; (add-hook 'python-mode-hook
    ;;     (lambda ()
    ;;         (setq-local codeium/editor_options/tab_size 4)))

    ;; 限制发送到服务器的字符数量(utf8长度意义下3000字符)
    (defun my-codeium/document/text ()
      (buffer-substring-no-properties (max (- (point) 3000) (point-min)) (min (+ (point) 1000) (point-max))))

    ;; 限制了字符数量,就必须修改cursor_offset
    (defun my-codeium/document/cursor_offset ()
      (codeium-utf8-byte-length
       (buffer-substring-no-properties (max (- (point) 3000) (point-min)) (point))))
    (setq codeium/document/text 'my-codeium/document/text)
    (setq codeium/document/cursor_offset 'my-codeium/document/cursor_offset)
    )

  (use-package company
    :config
    (setq-default
     company-frontends '(
                         ;; company-pseudo-tooltip-frontend
                         company-pseudo-tooltip-unless-just-one-frontend
                         company-echo-metadata-frontend
                         ;; company-preview-if-just-one-frontend
                         company-preview-frontend
                         )))
  )
