;;; init-modeline.el --- Custom native modeline -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(maybe-require-package 'doom-modeline)
(doom-modeline-mode 1)

(setq doom-modeline-bar-width 0)
(setq doom-modeline-major-mode-icon nil)
(setq doom-modeline-buffer-state-icon nil)
(setq doom-modeline-buffer-file-name-style 'relative-from-project)

(custom-set-faces
  '(mode-line ((t (:slant italic))))
  '(mode-line-active ((t (:slant italic))))
  '(mode-line-inactive ((t (:slant italic)))))

(provide 'init-modeline)
;;; init-modeline.el ends here
