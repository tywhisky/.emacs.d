;;; init-modeline.el --- Configuration for modeline -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(maybe-require-package 'doom-modeline)
(doom-modeline-mode 1)

(setq doom-modeline-height 23)

;; doom-modeline-position-column-line-format need
;; both column-number-mode and line-number-mode enabled
(column-number-mode 1)
(line-number-mode 1)
(setq doom-modeline-position-column-line-format '("%l:%c"))

(display-time-mode 1)
(display-battery-mode 1)

(provide 'init-modeline)
