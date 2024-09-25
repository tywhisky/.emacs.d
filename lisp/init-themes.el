;;; init-themes.el --- Defaults for themes -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Don't prompt to confirm theme safety. This avoids problems with
;; first-time startup on Emacs > 26.3.
(setq custom-safe-themes t)

(maybe-require-package 'color-theme-sanityinc-tomorrow)
(maybe-require-package 'ef-themes)

;; Set the default theme
;; (load-theme 'ef-maris-light t)
(load-theme 'ef-elea-dark t)

(provide 'init-themes)
