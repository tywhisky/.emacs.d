;;; init-modeline.el --- Configuration for modeline -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(maybe-require-package 'doom-modeline)
(doom-modeline-mode 1)


;; Configuration for modeline

;; Remove modeline border
(set-face-attribute 'mode-line nil :box nil)


;; Configuration for doom-modeline

;; doom-modeline-position-column-line-format need
;; both column-number-mode and line-number-mode enabled
(column-number-mode 1)
(line-number-mode 1)
(setq doom-modeline-position-column-line-format '("%l:%c"))

(setq doom-modeline-height 30)
(setq doom-modeline-icon nil)

(set-face-background 'doom-modeline-bar (face-background 'mode-line))

;; Font Family
(let ((family "Roboto Mono")
      (slant 'italic)
      (weight 'light)
      (box nil))
  (custom-set-faces
   `(mode-line ((t (:family ,family :slant ,slant :weight ,weight :box ,box))))
   `(mode-line-active ((t (:family ,family :slant ,slant :weight ,weight :box ,box))))
   `(mode-line-inactive ((t (:family ,family :slant ,slant :weight ,weight :box ,box))))))

(provide 'init-modeline)
;;; init-modeline.el ends here
