;;; init-themes.el --- Defaults for themes -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Don't prompt to confirm theme safety. This avoids problems with
;; first-time startup on Emacs > 26.3.
(setq custom-safe-themes t)

;; (maybe-require-package 'color-theme-sanityinc-tomorrow)
(maybe-require-package 'ef-themes)

;; Set the default theme for terminal and GUI emacs
(if (display-graphic-p)
    (load-theme 'ef-light t) 
  (load-theme 'ef-night t))

(provide 'init-themes)
;;; init-themes.el ends here
