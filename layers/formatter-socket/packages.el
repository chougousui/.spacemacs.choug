;;; packages.el --- formatter-socket layer packages file for Spacemacs.
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
;; added to `formatter-socket-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `formatter-socket/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `formatter-socket/pre-init-PACKAGE' and/or
;;   `formatter-socket/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst formatter-socket-packages
  '(reformatter))

(defun formatter-socket/init-reformatter ()
  (use-package reformatter
    :config
;;;###autoload (autoload 'ruff-format-buffer "ruff-format" nil t)
;;;###autoload (autoload 'ruff-format-region "ruff-format" nil t)
;;;###autoload (autoload 'ruff-format-on-save-mode "ruff-format" nil t)
    (reformatter-define ruff-format
      :program "ruff"
      :args (list "format" "--stdin-filename" (buffer-file-name) "-"))
;;;###autoload (autoload 'dprint-format-buffer "dprint-format" nil t)
;;;###autoload (autoload 'dprint-format-region "dprint-format" nil t)
;;;###autoload (autoload 'drpint-format-on-save-mode "dprint-format" nil t)
    (reformatter-define dprint-format
      :program "dprint"
      :args (list "fmt" "--stdin" (or (buffer-file-name) input-file)))

;;;###autoload (autoload 'shell-format-buffer "shell-format" nil t)
;;;###autoload (autoload 'shell-format-region "shell-format" nil t)
;;;###autoload (autoload 'shell-format-on-save-mode "shell-format" nil t)
    (reformatter-define shell-format
      :program "beautysh"
      :args (list "-"))

;;;###autoload (autoload 'lua-format-buffer "shell-format" nil t)
;;;###autoload (autoload 'lua-format-region "shell-format" nil t)
;;;###autoload (autoload 'lua-format-on-save-mode "shell-format" nil t)
    (reformatter-define lua-format
      :program "stylua"
      :args (list "--stdin-filepath" (or (buffer-file-name) input-file) "-"))
    ))
