;;; init-sis.el --- Emacs-Smart-Input-Source -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(maybe-require-package 'sis)

(sis-ism-lazyman-config
 "com.apple.keylayout.ABC"
 "com.apple.inputmethod.SCIM.ITABC")

(setq sis-other-cursor-color (face-foreground 'success nil t))

(if (display-graphic-p)
    (progn
      (sis-global-cursor-color-mode t)
      (sis-global-respect-mode t)
      (sis-global-context-mode t)
      (sis-global-inline-mode t)))

(provide 'init-sis)

;;; init-sis.el ends here
