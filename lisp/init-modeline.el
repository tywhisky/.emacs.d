;;; init-modeline.el --- Configuration for modeline -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(maybe-require-package 'doom-modeline)
(doom-modeline-mode 1)

;; doom-modeline-position-column-line-format need
;; both column-number-mode and line-number-mode enabled
(column-number-mode 1)
(line-number-mode 1)
(setq doom-modeline-position-column-line-format '("%l:%c"))

;; specify font family and size in modeline
;; (setq doom-modeline-height 23)
(if (facep 'mode-line-active)
    (set-face-attribute 'mode-line-active nil
			:family "Maple Mono"
			:slant 'italic
			:weight 'semi-light)
  (set-face-attribute 'mode-line nil
		      :family "Maple Mono"
		      :slant 'italic))
(set-face-attribute 'mode-line-inactive nil
		    :family "Maple Mono"
		    :slant 'italic
		    :weight 'semi-light)

(display-time-mode 1)
(display-battery-mode 1)

(provide 'init-modeline)
