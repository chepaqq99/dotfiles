;; Don't show the splash screen
(setq inhibit-startup-message t)

;; Show column number by default
(column-number-mode 1)

;; Matching parentheses
(show-paren-mode 1)
(setq show-paren-style 'expression)

;; Scrolling settings
(setq scroll-step 1)
(setq scroll-margin 10)
(setq scroll-conservaxively 10000)

;; Turn off some unneeded UI elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Size file in %
(size-indication-mode t)

;; Highlight current line
(global-hl-line-mode t)

(setq use-dialog-box     nil) ;; No dialogs
(setq redisplay-dont-pause t)  ;; Better drawing

;; Highlight search resaults
(setq search-highlight        t)
(setq query-replace-highlight t)

;; Display line numbers in every buffer
(global-display-line-numbers-mode 1)

;; Alias for yes-or-no-p questions
(defalias 'yes-or-no-p 'y-or-n-p)

(set-face-attribute 'default nil :font "Terminus:pixelsize=24:antialias=false" )
(setq default-frame-alist '((font . "Terminus:pixelsize=24:antialias=false")))

;; Set cursor type
(setq-default cursor-type 'bar)

(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox t))

(use-package highlight-indent-guides
  :config
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  (setq highlight-indent-guides-method 'bitmap))

(use-package doom-modeline
  :init
  (doom-modeline-mode t))

(use-package which-key
  :config
  (which-key-mode))

(provide 'config-ui)
