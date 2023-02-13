(use-package helm
  :config
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (helm-mode 1))
(provide 'config-helm)
