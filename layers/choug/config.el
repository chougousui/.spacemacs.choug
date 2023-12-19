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

(with-eval-after-load 'git-gutter-fringe ;;need git-gutter as diff tools
  (set-face-background 'git-gutter-fr:added "#67b11d")
  (set-face-background 'git-gutter-fr:modified "#4f97d7")
  (set-face-background 'git-gutter-fr:deleted "#f2241f"))

(setq org-startup-indented t)
(setq undo-tree-auto-save-history nil)
(setq warning-suppress-types '((comp)))
(setq fill-column 120)
(setq sql-port 3307)

(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)
(add-hook 'css-mode-hook 'prettier-js-mode)
(add-hook 'php-mode-hook 'prettier-js-mode)

;; tsx mode本质是web-mode,但lsp在调整缩进时考虑的是web-mode
;; 因此手动加上 tsx mode情况下的缩进
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp--formatting-indent-alist '(typescript-tsx-mode . typescript-indent-level))
  ;; jsx使用web-mode,也需要配置
  (add-to-list 'lsp--formatting-indent-alist '(web-mode . typescript-indent-level)))

(with-eval-after-load 'git-gutter-fringe ;;need git-gutter as diff tools
  (set-face-background 'git-gutter-fr:added "#67b11d")
  (set-face-background 'git-gutter-fr:modified "#4f97d7")
  (set-face-background 'git-gutter-fr:deleted "#f2241f"))

;; typescript-tsx-mode中,禁止在=后面自动添加"
;; 否则写 onClick={() =>} 时,会出现 =">
;; 写 disabled={'x' === 'y'}时会出现 ="="=", angular只会在括号嵌套层次较深时出现这个问题,但react总是出现
;; with-eval-after-load只设置一次,不理想,希望每次进入该模式都设置,使用hook
(defun tsx-stop-auto-closeing ()
  ;; setq会影响其他buffer中基于web-mode的major mode,比如angular的html文件,因此使用setq-local
  (setq-local web-mode-auto-quote-style 3);; 代码中定义 1: "", 2: '', 3: {} 但程序界面里面定义为0 1 2
  (setq-local web-mode-enable-auto-quoting nil);; 代码中定义 1: "", 2: '', 3: {} 但程序界面里面定义为0 1 2
  )
(add-hook 'typescript-tsx-mode-hook 'tsx-stop-auto-closeing)

;; tsx-mode下需要自动补全单引号,jsx-mode下情况正常
(defvar tsx-electric-pairs '((?\' . ?\')) "electric pairs for tsx-mode.")
(defun tsx-add-electric-pairs ()
  (setq-local electric-pair-pairs (append electric-pair-pairs tsx-electric-pairs))
  (setq-local electric-pair-text-pairs electric-pair-pairs))
(add-hook 'typescript-tsx-mode-hook 'tsx-add-electric-pairs)

(defvar ts-organize-imports-on-save t
  "控制是否在保存ts文件前执行lsp-organize-imports")

(add-hook 'before-save-hook
  (lambda ()
    "在保存文件前,判断符合条件的话,就执行lsp-organize-imports"
    (when (and ts-organize-imports-on-save
               (eq major-mode 'typescript-mode)
               lsp-mode)
      (lsp-organize-imports))))

(add-hook 'find-file-hook 'choug/open-file-in-readonly-mode)
