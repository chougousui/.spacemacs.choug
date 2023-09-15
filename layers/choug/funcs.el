(defun choug/swiper-dwim ()
  (interactive)
  (swiper (if (region-active-p)
              (buffer-substring-no-properties
               (region-beginning)
               (region-end))
            (thing-at-point 'symbol)
            ))
  )

(defun choug/delete-word (arg)
  "Delete characters forward until encountering the end of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (delete-region (point) (progn (forward-word arg) (point))))

(defun choug/backward-delete-word (arg)
  "Delete characters backward until encountering the beginning of a word.
With argument ARG, do this that many times."
  (interactive "p")
  (choug/delete-word (- arg)))

(defun choug/backward-delete-word-or-region (&optional arg)
  (interactive "p")
  (if (region-active-p)
      (call-interactively #'delete-region)
    (choug/backward-delete-word arg)))

(defun choug/minify ()
  "从光标所在位置,至匹配的括号处,将选定的内容合并为一行"
  (interactive)
  (let ((start (point)))
    (save-excursion
      (forward-list)
      (delete-indentation nil start (point)))))

;; 自定义一个lsp相关函数,让lsp能移除未使用的imports
;; 但在启动lsp-mode之后才开始定义,否则函数找不到
(with-eval-after-load 'lsp-mode
  (defmacro lsp-make-interactive-code-actions (func-name &rest code-action-kinds)
    "重新定义一个可以绑定多个action到一个命令的宏"
    `(defun ,(intern (concat "lsp-" (symbol-name func-name))) ()
       ,(format "Perform multiple code actions: %s" (mapconcat 'identity code-action-kinds ", "))
       (interactive)
       (let ((lsp-auto-execute-action t))
         (dolist (action-kind (quote ,code-action-kinds))
           (condition-case nil
               (lsp-execute-code-action-by-kind action-kind)
             (lsp-no-code-actions
              (when (called-interactively-p 'any)
                (lsp--info (format "%s action not available" action-kind)))))))))

  ;; 定义一个用于移除未使用的imports的命令
  (lsp-make-interactive-code-action remove-unused-imports "source.removeUnusedImports")
  ;; 覆盖lsp-mode的默认定义,现在lsp-organize-imports会先去除不使用的内容,然后再排序
  ;; (不知为什么source.organizeImports没有按ts-ls的官方说明一样先去除不使用的内容)
  (lsp-make-interactive-code-actions organize-imports "source.removeUnusedImports" "source.organizeImports")
  )

(defun choug/align-comment-dwim ()
  "对齐一个区域内的注释,
   若已经指定区域,则直接调用,
   否则将光标所在括号范围作为区域"
  (interactive)
  ;; 获取注释符号用comment-start,可能为nil
  ;; let声明多个变量时不能有依赖关系,但let*可以
  (let* ((comment-start-char (or comment-start "//"))
        (align-pattern (concat "\\(\\s-*\\)" comment-start-char)))
    (if (region-active-p)
        (align-regexp (region-beginning) (region-end) align-pattern)
      (save-excursion
        (backward-up-list)
        (let ((start (point)))
          (forward-list)
          (align-regexp start (point) align-pattern))))))

