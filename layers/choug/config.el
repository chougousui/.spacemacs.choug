(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'php-mode-hook '(lambda () (setq c-basic-offset 2)))
(electric-pair-mode t)
(setq electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)

;; 阻止smartparens对文字前的括号进行补全
(add-hook 'smartparens-mode-hook 'spacemacs/toggle-smartparens-off)

;; 默认使用光标下的字符串作为helm-projectile-ag的搜索对象
(setq helm-ag-insert-at-point 'symbol)

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
;; (add-hook 'php-mode-hook 'prettier-js-mode)

(with-eval-after-load 'git-gutter-fringe ;;need git-gutter as diff tools
  (set-face-background 'git-gutter-fr:added "#67b11d")
  (set-face-background 'git-gutter-fr:modified "#4f97d7")
  (set-face-background 'git-gutter-fr:deleted "#f2241f"))

(add-to-list 'auto-mode-alist '("\\.jsonc\\'" . jsonc-mode))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; tsx模式bug颇多
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 1. 换行时由lsp给出缩进建议,而缩进时lsp提供的建议与typescript模式不同
;;    (以为是typescript-mode,实际上是web-mode)
;;    因此手动加上 tsx mode情况下的缩进
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp--formatting-indent-alist '(typescript-tsx-mode . typescript-indent-level))
  ;; jsx使用web-mode,也需要配置
  (add-to-list 'lsp--formatting-indent-alist '(web-mode . typescript-indent-level)))

;; 2. 写 onClick={() =>} 时,会出现 =">, 写 disabled={'x' === 'y'}时会出现 ="="="
;;    angular只会在括号嵌套层次较深时出现这个问题,但react总是出现
;;    因此需要关闭
;;    with-eval-after-load只设置一次,不理想,希望每次进入该模式都设置,使用hook
(add-hook 'typescript-tsx-mode-hook
          (lambda ()
            ;; tx-stop-auto-closing
            ;; setq会影响其他buffer中基于web-mode的major mode,比如angular的html文件,因此使用setq-local
            (setq-local web-mode-auto-quote-style 3);; 代码中定义 1: "", 2: '', 3: {} 但程序界面里面定义为0 1 2
            (setq-local web-mode-enable-auto-quoting nil);; 代码中定义 1: "", 2: '', 3: {} 但程序界面里面定义为0 1 2))
            ))

;; 3. tsx-mode总是无法自动补全单引号.而jsx-mode下情况正常
(defvar tsx-electric-pairs '((?\' . ?\')) "electric pairs for tsx-mode.")
(add-hook 'typescript-tsx-mode-hook
          (lambda ()
            (setq-local electric-pair-pairs (append electric-pair-pairs tsx-electric-pairs))
            (setq-local electric-pair-text-pairs electric-pair-pairs)
            ))
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 在保存文件前,判断符合条件的话,就执行lsp-organize-imports
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'typescript-mode-hook
          (lambda ()
            (add-hook 'before-save-hook
                      (lambda ()
                        (when (and t       ;; 根据需求换成nil,控制整体功能的开关
                                   (eq major-mode 'typescript-mode)
                                   lsp-mode)
                          (lsp-organize-imports))
                        ))))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 文件路径包含readonly,则以readonly模式打开文件
;; 通常将一些仅供参考的代码库重命名为readonly以避免对该代码库的修改
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'find-file-hook
          (lambda ()
            (when buffer-file-name
              (when (string-match-p "readonly" buffer-file-name)
                (setq buffer-read-only t)
                (message "File opened in readonly mode.")))
            ))

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 一些小众语言出于各种原因没有集成格式化工具.
;; 自行使用reformatter.el实现一些(需要在formatter-socket layer的初始化之后)
;; lua-layer没有为lua-mode集成格式化工具
;; rust-layer没有为toml-mode集成格式化工具
;; yaml=layer没有为yaml-mode集成格式化工具
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'lua-mode-hook #'lua-format-on-save-mode)
(add-hook 'toml-mode-hook #'dprint-format-on-save-mode)
(add-hook 'yaml-mode-hook #'dprint-format-on-save-mode)
(add-hook 'shell-script-mode #'shell-format-on-save-mode)

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; python改用性能更好的ruff formatter
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'python-mode-hook
          (lambda ()
            (when (eq python-formatter 'ruff)
              (ruff-format-on-save-mode t))))


;; conf-mode下自动显示行号
(add-hook 'conf-mode-hook #'display-line-numbers-mode)
