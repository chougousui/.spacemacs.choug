(defconst org-ext-packages
  '(
    (org-remoteimg :location (recipe
                              :fetcher github
                              :repo "chougousui/org-remoteimg"
                              :branch "dev"  ;; 需要去掉包中的Package-Requires,否则就会报错,原因未知
                              :files ("*.el")))
    ))

(defun org-ext/init-org-remoteimg ()
  (use-package org-remoteimg
    :defer nil     ;; 不知道为什么如果defer为t,则下面的add-hook不好用
    :config
    (add-hook 'org-mode-hook #'org-display-user-inline-images))
  )
