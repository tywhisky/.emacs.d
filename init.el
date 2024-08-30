;; -*- lexical-binding: t -*-

(set-frame-font "Iosevka 22" nil t)
(load-theme 'ef-maris-light :no-confirm)
(require 'doom-modeline)
(doom-modeline-mode 1)
(nyan-mode 1)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(add-to-list 'default-frame-alist '(height . 38))
(add-to-list 'default-frame-alist '(width . 90))
(global-display-line-numbers-mode t)

(setq make-backup-files nil)
(setq inhibit-startup-screen t)

(defun my/init-file ()
  "Open the init file."
  (interactive)
  (find-file user-init-file))

(add-hook 'after-init-hook 'global-company-mode)
(require 'company-box)
(add-hook 'company-mode-hook 'company-box-mode)
(require 'eglot)
(add-hook 'elixir-mode-hook 'eglot-ensure)
(add-to-list 'eglot-server-programs '(elixir-mode "~/.config/emacs/language-server/elixir/release/language_server.sh"))

(vertico-mode t)
(setq completion-styles '(orderless))
(marginalia-mode t)
(global-set-key (kbd "C-;") 'embark-act)
(global-set-key (kbd "C-s") 'consult-line)

(add-to-list 'package-archives
	     (cons "melpa" "https://melpa.org/packages/") t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(consult embark orderless marginalia vertico nyan-mode doom-modeline ef-themes company-box company elixir-mode yasnippet markdown-mode magit with-editor transient dash)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
