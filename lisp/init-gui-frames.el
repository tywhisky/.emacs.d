;;; init-gui-frames.el --- Behaviour specific to non-TTY frames -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Set English Font Family
;; (set-frame-font "Iosevka Nerd Font 16" nil t)
(set-frame-font "Maple Mono 14" nil t)

;; 设置中文字体
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font t charset (font-spec :family "LXGW WenKai" :size 15)))

(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

(desktop-save-mode 1)

(add-to-list 'default-frame-alist '(undecorated-round . t))

(maybe-require-package 'moom)
(with-eval-after-load 'moom
  (setq moom-use-font-module nil)
  (moom-mode 1))

(add-to-list 'default-frame-alist '(height . 38))
(add-to-list 'default-frame-alist '(width . 90))

(global-display-line-numbers-mode t)

(setq make-backup-files nil)
(setq inhibit-startup-screen t)

(provide 'init-gui-frames)
