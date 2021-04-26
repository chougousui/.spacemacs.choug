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
