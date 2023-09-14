(defvar w3work/my-after-save-flag t
  "控制my-after-save-function能否执行"
  )

(add-hook 'after-save-hook 'w3work/my-after-save-function)
(add-hook 'php-mode-hook '(lambda () (setq c-basic-offset 2)))
