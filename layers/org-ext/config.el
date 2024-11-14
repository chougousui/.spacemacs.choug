(defun org-ext-setup-org-download ()
  "使用自定义的org-ext--dir替换org-download包的org-download--dir函数。
用以自定义org-download下载图片的保存路径。"
  (with-eval-after-load 'org-download
    (fset 'org-download--dir #'org-ext--dir)))

(defun org-ext--dir ()
  "计算org-download所下载文件的保存路径
org-download--dir-1: .
org-ext--dir-2a: 与当前org文件同名的文件夹

合起来就是 ./org文件同名文件夹"
  (let* ((part1 (org-download--dir-1))
         (part2 (org-ext--dir-2a))
         (dir (if part2
                  (expand-file-name part2 part1)
                part1)))
    (unless (file-exists-p dir)
      (make-directory dir t))
    dir))

(defun org-ext--dir-2a ()
  "获取当前org文件名(不带后缀)"
  (when (buffer-file-name)
    (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))

;; 生效上面的替换行为
(org-ext-setup-org-download)
