(defvar w3work/my-after-save-flag nil
  "控制my-after-save-function能否执行"
  )

(add-hook 'after-save-hook 'w3work/my-after-save-function)
