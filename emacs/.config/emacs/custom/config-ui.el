(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox t))

(use-package highlight-indent-guides
  :config
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  (setq highlight-indent-guides-method 'character))

(use-package doom-modeline
  :init
  (doom-modeline-mode t))

(use-package which-key
  :config
  (which-key-mode))

(provide 'config-ui)
