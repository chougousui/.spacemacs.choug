(add-hook 'after-init-hook 'global-company-mode)
;; (add-hook 'php-mode-hook '(lambda () (setq c-basic-offset 2)))
;; (global-git-gutter-mode t)
;; (global-superword-mode 1)
(electric-pair-mode t)
(setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)
;;(spacemacs/toggle-smartparens-globally-off)

(defvar version-control-diff-tool 'diff-hl
  "Options are `git-gutter', `git-gutter+', and `diff-hl' to show
version-control markers.")

(defvar version-control-diff-side 'left
  "Side on which to show version-control markers.
Options are `left' and `right'.")

;; 阻止smartparens对文字前的括号进行补全
(add-hook 'smartparens-mode-hook 'spacemacs/toggle-smartparens-off)

;; 默认开启org-indent-mode
(add-hook 'org-mode-hook 'org-indent-mode)

;; 默认使用光标下的字符串作为helm-projectile-ag的搜索对象
(setq helm-ag-insert-at-point 'symbol)

;; (set-face-background 'git-gutter-fr:added "green")
;; (set-face-background 'git-gutter-fr:modified "yellow")
;; (set-face-background 'git-gutter-fr:deleted "red")
