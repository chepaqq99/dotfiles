(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-startup-indented t
      org-pretty-entities t
      org-log-done t
      org-todo-keywords '((sequence "TODO(t)" "DOING(g)" "|" "DONE(d)"))
      org-hide-emphasis-markers t
      org-log-done t
      org-agenda-files '("~/Documents/Todo/")
      org-startup-with-inline-images t
      org-image-actual-width '(300))
(provide 'config-org)
