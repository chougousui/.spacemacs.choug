(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-s") 'swiper)
(global-set-key (kbd "C-S-s") 'choug/swiper-dwim)
(global-set-key (kbd "C-M-s") 'choug/consult-ripgrep-dwim)
(global-set-key (kbd "C-;") 'iedit-mode)
(global-set-key (kbd "<C-backspace>") 'choug/backward-delete-word-or-region)
(global-set-key (kbd "M-DEL") 'choug/backward-delete-word-or-region)
(global-unset-key (kbd "C-t"))
(global-set-key (kbd "C-}") 'centaur-tabs-forward)
(global-set-key (kbd "C-{") 'centaur-tabs-backward)
(global-set-key (kbd "M-m i e") 'tiny-expand)
(global-set-key (kbd "M-m b t") 'choug/open-temp-note)
(global-set-key (kbd "M-s f") 'consult-fd)
(global-set-key (kbd "M-m f y y") 'spacemacs/projectile-copy-file-path)

;; 发现M-m y还没有被占用,刚才拿来
;; 以下内容使用预设的leader key M-m,并可以为key添加注释性文字(默认+prefix)
(spacemacs|spacebind
 :global
 (("y" "choug"
   ;; 等效于(global-set-key (kbd "M-m y a") 'choug/align-comment-dwim)
   ("a" choug/align-comment-dwim "align commentn")
   ("m" choug/minify "minify"))))
