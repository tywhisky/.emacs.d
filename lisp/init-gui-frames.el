;;; init-gui-frames.el --- Behaviour specific to non-TTY frames -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Set English Font Family
;; (set-frame-font "Iosevka Nerd Font 16" nil t)
(set-frame-font "Maple Mono 14" nil t)

;; 设置中文字体
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font t charset (font-spec :family "LXGW WenKai" :size 15)))

;; Remove tool-bar; menu-bar; scroll-bar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
;; Hide the title-bar with round corners, only for emacs 30+
(add-to-list 'default-frame-alist '(undecorated-round . t))

(if (display-graphic-p)
    ;; If in GUI mode, enable desktop-save-mode
    (desktop-save-mode 1)
  ;; If in terminal mode, disable desktop-save-mode
  (desktop-save-mode -1))

(maybe-require-package 'moom)
(with-eval-after-load 'moom
  (setq moom-use-font-module nil)
  (moom-mode 1))

(global-display-line-numbers-mode t)

(setq make-backup-files nil)
(setq inhibit-startup-screen t)

(provide 'init-gui-frames)
;;; init-gui-frames.el ends here
