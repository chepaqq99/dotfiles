(use-package helm
  :config
  (helm-autoresize-mode 1)
  (helm-mode 1))

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-c h o") 'helm-occur)
(global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
(global-set-key (kbd "C-c h M-:") 'helm-eval-expression-with-eldoc)

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
(define-key minibuffer-local-map (kbd "C-c C-l") 'helm-minibuffer-history)


(when (executable-find "curl")
  (setq helm-google-suggest-use-curl-p t))

(add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)

(setq helm-split-window-in-side-p t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.
      helm-scroll-amount                    8 ; scroll 8 lines other window using M-<next>/M-<prior>
      helm-ff-file-name-history-use-recentf t
      helm-autoresize-max-height 0
      helm-autoresize-min-height 30
      ;; fuzzy matching
      helm-M-x-fuzzy-match t
      helm-buffers-fuzzy-matching t
      helm-locate-fuzzy-match t)


(provide 'config-helm)
