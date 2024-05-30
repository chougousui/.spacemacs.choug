(defconst pyim-flypy-workman-packages
  '(
    pyim
    pyim-basedict
    (pyim-tsinghua-dict ;; 仅仅将pyim-tsinghua-dict-xxxx安装到elpa下还不够,还需要将词库文件pyim放到里面
     :location (recipe
                :fetcher github
                :repo "redguardtoo/pyim-tsinghua-dict"
                :branch "master"))
    )
  )

;; 约定好的初始化函数命名 <layer名>/init-<包名>
(defun pyim-flypy-workman/init-pyim ()
  (use-package pyim
    :defer t
    :init
    (setq pyim-directory (expand-file-name "pyim/" spacemacs-cache-directory)
          pyim-dcache-directory (expand-file-name "dcache/" pyim-directory)
          pyim-assistant-scheme-enable t
          default-input-method "pyim")
    (autoload 'pyim-dict-manager-mode "pyim-dicts-manager"
      "Major mode for managing pyim dicts")
    (evilified-state-evilify-map pyim-dict-manager-mode-map
                                 :mode pyim-dict-manager-mode
                                 :eval-after-load pyim-dict-manager)
    (setq default-input-method 'pyim)
    :config                             ;; 初始化完毕后开始执行config代码
    (pyim-scheme-add flypy-workman-scheme)
    (setq pyim-default-scheme 'flypy-workman
          pyim-page-length 7)
    (pyim-basedict-enable)
    (pyim-tsinghua-dict-enable)))

(defun pyim-flypy-workman/init-pyim-basedict ()
  "Initialize pyim-basedict"
  (use-package pyim-basedict
    :defer t
    :config
    (pyim-basedict-enable)))

(defun pyim-flypy-workman/init-pyim-tsinghua-dict ()
  "Initialize pyim-basedict"
  (use-package pyim-tsinghua-dict
    :defer t
    :config
    (pyim-tsinghua-dict-enable)))

