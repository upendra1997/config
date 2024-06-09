(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("7b8f5bbdc7c316ee62f271acf6bcd0e0b8a272fdffe908f8c920b0ba34871d98" "f366d4bc6d14dcac2963d45df51956b2409a15b770ec2f6d730e73ce0ca5c8a7" default))
 '(fido-mode t)
 '(obsidian-directory "~/personal/obsidian")
 '(package-selected-packages
   '(gruvbox-theme obsidian ereader nix-mode direnv magit tree-sitter-langs company yasnippet magit markdown-mode cider paredit)))

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

(global-display-line-numbers-mode 1)

(when window-system
  (tool-bar-mode nil)
  (scroll-bar-mode nil))

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

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; hack to ensure that we are adding all the values from the emacs.pkgs in nix to emacs load path, this was specifically done to ensuer that vterm works to compile vterm-modle. we looked at: https://discourse.nixos.org/t/is-it-currently-possible-to-use-emacs-on-aarch64-darwin/31571/19
;; (add-to-list 'load-path  "~/.nix-profile/share/emacs/site-lisp/elpa/vterm-20230417.424/")
;; (let ((default-directory  "~/.nix-profile/share/emacs/site-lisp/"))
;; (normal-top-level-add-subdirs-to-load-path))
