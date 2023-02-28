(use-package vterm
  :config
  (setq vterm-timer-delay 0.001))

(add-to-list 'display-buffer-alist
     '("*vterm*"
       (display-buffer-in-side-window)
       (window-height . 0.25)
       (side . bottom)
       (slot . 0)))

(provide 'config-term)
