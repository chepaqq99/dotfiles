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

(add-to-list 'load-path (concat user-emacs-directory "/custom/"))
(setq custom-file (make-temp-name "/tmp/"))

(require 'config-company)
(require 'config-editing)
(require 'config-go)
(require 'config-helm)
(require 'config-latex)
(require 'config-lsp)
(require 'config-org)
(require 'config-pairs)
(require 'config-pdf-tools)
(require 'config-speedbar)
(require 'config-term)
(require 'config-ui)
(require 'config-vcs)
(require 'config-yasnippet)
