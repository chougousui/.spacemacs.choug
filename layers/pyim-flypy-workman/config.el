(defconst flypy-workman-scheme
  '(flypy-workman
    :document "参考小鹤双拼韵母在workman键盘布局上的位置,修改而来"
    :class shuangpin
    :first-chars "abcdefghijklmnpqrstuvwxyz"
    :rest-chars "abcdefghijklmnopqrstuvwxyz"
    :prefer-triggers ("o")
    :cregexp-support-p t
    :keymaps
    (("a" "a" "a")
     ("b" "b" "ue" "ve")
     ("c" "c" "ao")
     ("d" "d" "iang" "uang")
     ("e" "sh" "e" "e")
     ("f" "f" "ing" "uai")
     ("g" "g" "ang")
     ("h" "h" "ai")
     ("i" "ch" "i")
     ("j" "j" "un")
     ("k" "k" "iao")
     ("l" "l" "ian")
     ("m" "m" "in")
     ("n" "n" "en")
     ("o" "o" "uo" "o")                  ;; o重复了两次,不知道为什么这样写
     ("p" "p" "ie")
     ("q" "q" "iu")
     ("r" "r" "uan")
     ("s" "s" "iong" "ong")
     ("t" "t" "an")
     ("u" "zh" "u")
     ("v" "v" "ui")
     ("w" "w" "ei")
     ("x" "x" "ia" "ua")
     ("y" "y" "eng")
     ("z" "z" "ou")
     ("aa" "a")
     ("an" "an")                        ;; 注意一些两字韵母,能用原本的就用原版的,避开使用at等
     ("ai" "ai")
     ("ao" "ao")
     ("ah" "ang")
     ("ee" "e")
     ("er" "er")
     ("eg" "eng")
     ("ag" "ng")
     ("ou" "ou"))))
