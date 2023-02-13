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

(require 'config-general)
(require 'config-editing)
(require 'config-ui)
(require 'config-helm)
(require 'config-company)
(require 'config-go)
(require 'config-lsp)
(require 'config-pdf-tools)
(require 'config-vcs)
(require 'config-yasnippet)
