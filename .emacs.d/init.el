(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f366d4bc6d14dcac2963d45df51956b2409a15b770ec2f6d730e73ce0ca5c8a7" default))
 '(package-selected-packages
   '(zenburn-theme magit tree-sitter-langs company yasnippet magit markdown-mode cider paredit)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(use-package evil
  :ensure t
  ;; :init
  ;; (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  ;; (setq evil-want-keybinding nil)
  :config
  (evil-mode 1))

(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode))

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1))

(use-package magit
  :ensure t)

(use-package markdown-mode
  :ensure t)

(use-package cider
  :ensure t)

(use-package paredit
  :ensure t)

(use-package zenburn-theme
  :ensure t
  :init
  (load-theme 'zenburn t))

(global-display-line-numbers-mode 1)

(when window-system
  (tool-bar-mode -1)
  (scroll-bar-mode -1))

;; (use-package evil-collection
;;   :after evil
;;   :ensure t
;;   :config
;;   (evil-collection-init))

;; (pdf-tools-install)
;; (pdf-loader-install)
