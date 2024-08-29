(set-frame-font "Iosevka 22" nil t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(add-to-list 'default-frame-alist '(height . 34))
(add-to-list 'default-frame-alist '(width . 80))

(setq make-backup-files nil)
(setq inhibit-startup-screen t)

(defun my-init-file ()
  "Open the init file."
  (interactive)
  (find-file user-init-file))

(add-to-list 'package-archives
             (cons "melpa" "https://melpa.org/packages/")
             t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(magit with-editor transient dash)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
