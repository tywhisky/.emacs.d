;;; early-init.el --- Early init file -*- lexical-binding: t; -*-

;;; Commentary:

;; Keep byte-compiled packages separate across Emacs versions.

;;; Code:

(setq package-user-dir
      (locate-user-emacs-file
       (format "elpa-%s.%s/" emacs-major-version emacs-minor-version)))

;; So we can detect this having been loaded
(provide 'early-init)

;;; early-init.el ends here
