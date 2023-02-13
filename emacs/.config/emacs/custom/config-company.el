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

(provide 'config-company)
