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

(use-package move-dup
  :config
  (global-set-key (kbd "M-n") 'move-dup-move-lines-up)
  (global-set-key (kbd "M-p") 'move-dup-move-lines-down))

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(provide 'config-editing)
