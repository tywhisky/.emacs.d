(set-frame-font "Iosevka 22" nil t)
(load-theme 'ef-maris-light)
(require 'doom-modeline)
(doom-modeline-mode 1)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(add-to-list 'default-frame-alist '(height . 38))
(add-to-list 'default-frame-alist '(width . 80))

(setq make-backup-files nil)
(setq inhibit-startup-screen t)

(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

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

(add-to-list 'package-archives
	     (cons "melpa" "https://melpa.org/packages/") t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("856bf0048f0e6cf6e1e3eba8b3ba6467ac1bc6f9d6855f43042cc90443fe8727" default))
 '(package-selected-packages
   '(doom-modeline ef-themes company-box company elixir-mode yasnippet markdown-mode magit with-editor transient dash)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
