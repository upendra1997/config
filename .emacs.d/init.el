(require 'package)
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
       '("melpa" . "https://melpa.org/packages/") t)

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

(use-package direnv
  :ensure t)

(use-package nix-mode
  :ensure t)

(use-package gruber-darker-theme
  :ensure t
  :init)

(global-display-line-numbers-mode 1)

(when window-system
  (menu-bar-mode nil)
  (tool-bar-mode nil)
  (scroll-bar-mode nil))

(load-theme 'gruber-darker t)

;; (use-package evil-collection
;;   :after evil
;;   :ensure t
;;   :config
;;   (evil-collection-init))

;; (pdf-tools-install)
;; (pdf-loader-install)

(global-set-key [remap list-buffers] 'ibuffer)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-i") 'imenu)
;; (global-set-key (kbd "SPC f f") 'eglot-format)
(repeat-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("01a9797244146bbae39b18ef37e6f2ca5bebded90d9fe3a2f342a9e863aaa4fd" default))
 '(package-selected-packages
   '(rust-mode nixpkgs-fmt nixos-options haskell-mode go-mode zenburn-theme yasnippet vterm tree-sitter-langs pdf-tools paredit obsidian nix-mode magit gruvbox-theme gruber-darker-theme evil-collection ereader direnv company cider)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
