(setq indent-tabs-mode nil ; Use spaces instead of tabs
      tab-width 4 ; Default tab width
      fill-column 80
      history-length 25 ; Minibuffer history length
      global-auto-revert-non-file-buffers t ; Revert other buffers
      require-final-newline t ; Enter new line in end of file
      make-backup-files nil  ; Don't want any backup
      auto-save-list-file-name nil; Don't want any .saves
      auto-save-default nil) ; Don't want any ato saving files

(global-visual-line-mode 1) ; Line wraping
(delete-selection-mode 1) ; Overwrite region
(auto-revert-mode 1) ; Revert file buffers
(save-place-mode 1) ; Remember cursor position
(savehist-mode 1) ; Minibuffer history

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

(defun shift-text (distance)
  "Shift a region or a line"
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
  "Shift a line to right"
  (interactive "p")
  (shift-text count))

(defun shift-left (count)
  "Shift a line to left"
  (interactive "p")
  (shift-text (- count)))

(global-set-key (kbd "C->") 'shift-right)
(global-set-key (kbd "C-<") 'shift-left)

(global-set-key (kbd "RET") 'newline-and-indent) ;; Indent with new line

(use-package move-dup
  :bind
  ("M-n" . move-dup-move-lines-up)
  ("M-p" . move-dup-move-lines-down))

(defun my-god-mode-update-cursor-type ()
  (setq cursor-type (if (or god-local-mode buffer-read-only) 'box 'bar)))

;; Easy transition between buffers: M-arrow-keys
(if (equal nil (equal major-mode 'org-mode))
    (windmove-default-keybindings 'meta))

;; Delete trailing whitespaces, format buffer and untabify when save buffer
(defun format-current-buffer()
  (indent-region (point-min) (point-max)))
(defun untabify-current-buffer()
  (if (not indent-tabs-mode)
      (untabify (point-min) (point-max)))
  nil)
(add-hook 'before-save-hook 'format-current-buffer)
(add-hook 'before-save-hook 'untabify-current-buffer)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(use-package god-mode
  :config
  (setq god-mode-enable-function-key-translation nil)
  (setq god-exempt-major-modes nil)
  (setq god-exempt-predicates nil)
  :init
  (global-set-key (kbd "<escape>") #'god-local-mode)
  (global-set-key (kbd "C-x C-1") #'delete-other-windows)
  (global-set-key (kbd "C-x C-2") #'split-window-below)
  (global-set-key (kbd "C-x C-3") #'split-window-right)
  (global-set-key (kbd "C-x C-0") #'delete-window)
  (add-hook 'post-command-hook #'my-god-mode-update-cursor-type))

(define-key god-local-mode-map (kbd "z") #'repeat)
(define-key god-local-mode-map (kbd "i") #'god-local-mode)
(define-key god-local-mode-map (kbd "[") #'backward-paragraph)
(define-key god-local-mode-map (kbd "]") #'forward-paragraph)

(provide 'config-editing)
