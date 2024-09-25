;;; init-gui-frames.el --- Behaviour specific to non-TTY frames -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(set-frame-font "Iosevka Nerd Font 16" nil t)

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(add-to-list 'default-frame-alist '(undecorated-round . t))
(add-to-list 'default-frame-alist '(height . 38))
(add-to-list 'default-frame-alist '(width . 90))

(global-display-line-numbers-mode t)

(setq make-backup-files nil)
(setq inhibit-startup-screen t)

(provide 'init-gui-frames)
