(defun w3work/toggle-my-after-save ()
  "切换变量w3work/my-after-save-flag的值,因为 set-variable 命令后出现的列表中找不到这个变量"
  (interactive)
  (setq w3work/my-after-save-flag (not w3work/my-after-save-flag))
  )

(defun w3work/my-after-save-function ()
  "检查当前情况是否满足条件,若满足则调用w3work/rsync-and-call"
  (when (and
         (eq major-mode 'php-mode) ; 检查 major mode 是否为 php-mode
         (string-prefix-p
          "/home/choug/works/prog/w3package_v2/app/Services/Alternatives/Lawson/"
          (file-name-directory buffer-file-name))) ; 检查文件路径前缀
    (w3work/rsync-and-call)))


(defun w3work/rsync-and-call ()
  "以当前buffer文件路径为参数,调用一个bash脚本"
  (interactive)
  (message "================")
  (when buffer-file-name
    (let ((file-path (expand-file-name buffer-file-name)))
      (message "Calling trigger.sh with file path: %s" file-path)
      (shell-command (format "bash /home/choug/prog/sse-test/trigger.sh %s" (shell-quote-argument file-path)))
      (message "Executed trigger.sh"))))
