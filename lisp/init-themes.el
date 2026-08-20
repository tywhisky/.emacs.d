;;; init-themes.el --- Defaults for themes -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Set the default theme for terminal and GUI Emacs.

(maybe-require-package 'doric-themes)

(add-hook 'after-init-hook
          (lambda ()
            (doric-themes-select 'doric-light)))

;; Common Theme Config
(custom-set-faces
 '(fill-column-indicator
   ((t (:height 0.1)))))



(when (maybe-require-package 'beacon)
  (setq-default beacon-blink-when-window-changes t
                beacon-blink-when-buffer-changes t)
  (add-hook 'after-init-hook 'beacon-mode))


(provide 'init-themes)
;;; init-themes.el ends here
