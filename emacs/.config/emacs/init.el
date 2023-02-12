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

;; make electric-pair-mode work on more brackets
(setq electric-pair-pairs
      '(
        (?\" . ?\")
        (?\{ . ?\})))

;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)

(setq make-backup-files         nil) ; Don't want any backup files
(setq auto-save-list-file-name  nil) ; Don't want any .saves files
(setq auto-save-default         nil) ; Don't want any auto saving

;; Set custom fle
(setq custom-file (concat user-emacs-directory "/custom.el"))

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

;; Start emacs as server
(require 'server)
(unless (server-running))
  (server-start)

;; My name and email
(setq user-full-name "Maksym Chepak")
(setq user-mail-address "chepaqq@pm.me")

;; Include Melpa in list of package archives
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)

;; Check if use-package install
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  ;; (company-tng-configure-default)
  (setq company-idle-delay 0)
  (setq lsp-completion-provider :none)
  (setq company-backends
    '((company-files :with company-yasnippet)
      (company-capf :with company-yasnippet)
      (company-dabbrev-code company-gtags company-etags company-keywords :with company-yasnippet)
      (company-dabbrev :with company-yasnippet)))
  (setq company-minimum-prefix-length 1))

(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox t))

(use-package highlight-indent-guides
  :config
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  (setq highlight-indent-guides-method 'character))

(use-package buffer-move
  :config
  (global-set-key (kbd "<C-S-up>") 'buf-move-up)
  (global-set-key (kbd "<C-S-down>") 'buf-move-down)
  (global-set-key (kbd "<C-S-left>") 'buf-move-left)
  (global-set-key (kbd "<C-S-right>") 'buf-move-right))

(use-package move-dup
  :config
  (global-set-key (kbd "M-n") 'move-dup-move-lines-up)
  (global-set-key (kbd "M-p") 'move-dup-move-lines-down))

(use-package doom-modeline
  :init
  (doom-modeline-mode +1))

(use-package yasnippet
  :config
  (yas-global-mode 1))

(use-package yasnippet-snippets)

(use-package helm
  :config
  (global-set-key (kbd "C-x C-f") 'helm-find-files)
  (helm-mode 1))

(use-package which-key
  :config
  (which-key-mode))

(use-package sr-speedbar)
(use-package go-mode)
(use-package pdf-tools
  :pin manual ;; manually update
  :config
  ;; initialise
  (pdf-tools-install)
  ;; open pdfs scaled to fit page
  (setq-default pdf-view-display-size 'fit-page)
  ;; automatically annotate highlights
  (setq pdf-annot-activate-created-annotations t)
  ;; use normal isearch
  (define-key pdf-view-mode-map (kbd "C-s") 'isearch-forward))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook
  ((go-mode) . lsp))

(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook 'lsp-format-buffer t t)
  (add-hook 'before-save-hook 'lsp-organize-imports t t))
(add-hook 'go-mode-hook 'lsp-go-install-save-hooks)

;; Shift a region or line
(defun shift-text (distance)
  (if (use-region-p)
      (let ((mark (mark)))
        (save-excursion
          (indent-rigidly (region-beginning)
                          (region-end)
                          distance)
          (push-mark mark t t)
          (setq deactivate-mark nil)))
    (indent-rigidly (line-beginning-position)
                    (line-end-position)
                    distance)))

(defun shift-right (count)
  (interactive "p")
  (shift-text count))

(defun shift-left (count)
  (interactive "p")
  (shift-text (- count)))

(global-set-key (kbd "C->") 'shift-right)
(global-set-key (kbd "C-<") 'shift-left)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Set font
(add-to-list 'default-frame-alist '(font . "Terminus:pixelsize=24:antialias =false" ))
(set-face-attribute 'default nil :font "Terminus:pixelsize=24:antialias=false" )

;; Behave like vi's o command
(defun open-next-line (arg)
  "Move to the next line and then opens a line."
  (interactive "p")
  (end-of-line)
  (open-line arg)
  (forward-line 1)
  (when newline-and-indent
    (indent-according-to-mode)))

(global-set-key (kbd "C-o") 'open-next-line)

;; Behave like vi's O command
(defun open-previous-line (arg)
  "Open a new line before the current one."
  (interactive "p")
  (beginning-of-line)
  (open-line arg)
  (when newline-and-indent
    (indent-according-to-mode)))

(global-set-key (kbd "M-o") 'open-previous-line)

;; Autoindent open-*-lines
(defvar newline-and-indent t
  "Modify the behavior of the open-*-line functions to cause them to autoindent.")
