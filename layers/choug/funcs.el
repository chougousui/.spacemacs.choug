(defun choug/swiper-dwim ()
  (interactive)
  (swiper (if (region-active-p)
              (buffer-substring-no-properties
               (region-beginning)
               (region-end))
            (thing-at-point 'symbol)
            ))
  )
