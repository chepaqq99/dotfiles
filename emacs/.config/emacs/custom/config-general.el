;; Don't show the splash screen
(setq inhibit-startup-message t)

;; Show column number by default
(column-number-mode 1)

;; Matching parentheses
(show-paren-mode 1)
(setq show-paren-style 'expression)

;; Overwrite region
(delete-selection-mode 1)

;; Toggle automatic parens pairing
(electric-pair-mode 1)

;; Save last position
(save-place-mode 1)

;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)

(setq make-backup-files         nil) ; Don't want any backup files
(setq auto-save-list-file-name  nil) ; Don't want any .saves files
(setq auto-save-default         nil) ; Don't want any auto saving

;; Turn off some unneeded UI elements
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Highlight current line
(global-hl-line-mode t)

;; Display line numbers in every buffer
(global-display-line-numbers-mode 1)

;; Set cursor type
(setq-default cursor-type 'bar)

;; My name and email
(setq user-full-name "Maksym Chepak")
(setq user-mail-address "chepaqq@pm.me")

;; make electric-pair-mode work on more brackets
(setq electric-pair-pairs
      '(
        (?\" . ?\")
        (?\{ . ?\})))

(add-to-list 'default-frame-alist '(font . "Terminus:pixelsize=24:antialias =false" ))
(set-face-attribute 'default nil :font "Terminus:pixelsize=24:antialias=false" )

(use-package sr-speedbar)

(provide 'config-general)
