;;; init-gui-frames.el --- Behaviour specific to non-TTY frames -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; Favor font list:
;; Monaspace Neon Var
;; Maple Mono
;; LXGW WenKai
;; FantasqueSansM Nerd Font Propo

(when (display-graphic-p)
  (setq display-hourglass t
        hourglass-delay 0.3)

  ;; Set English Font Family
  ;; (set-frame-font "Iosevka Nerd Font 16" nil t)
  ;; (set-frame-font "FantasqueSansM Nerd Font Mono 16" nil t)
  (set-frame-font "Lilex Nerd Font Mono 14" nil t)

  ;; Set CJK font.
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font t charset (font-spec :family "LXGW WenKai" :size 15))))

(add-hook 'after-init-hook
  (lambda ()
    (set-face-attribute 'line-number nil
                        :family "Fira Code"
                        :height 135
                        :weight 'normal)))

;; Remove tool-bar; menu-bar; scroll-bar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
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

(setq inhibit-startup-screen t)


(maybe-require-package 'spacious-padding)

(setq spacious-padding-widths
      '( :internal-border-width 15
         :header-line-width 4
         :mode-line-width 4
         :tab-width 4
         :right-divider-width 1
         :scroll-bar-width 8
         :fringe-width 0))

(setq window-divider-default-places t
      window-divider-default-right-width 1
      window-divider-default-bottom-width 1)
(window-divider-mode 1)

(when (fboundp 'spacious-padding-mode)
  (spacious-padding-mode 1))



;; Initialize the settings
(setq scroll-conservatively 101) ; important!
(setq scroll-margin 0)
(pixel-scroll-precision-mode 1)

(global-set-key (kbd "<pinch>") 'ignore)
(global-set-key (kbd "<C-wheel-up>") 'ignore)
(global-set-key (kbd "<C-wheel-down>") 'ignore)

(provide 'init-gui-frames)
;;; init-gui-frames.el ends here
