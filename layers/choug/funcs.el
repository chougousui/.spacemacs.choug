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
;; (add-hook 'lsp-mode-hook '(lambda () (lsp-make-interactive-code-action remove-unused-imports "source.removeUnusedImports")))
(with-eval-after-load 'lsp-mode
  (lsp-make-interactive-code-action remove-unused-imports "source.removeUnusedImports"))
