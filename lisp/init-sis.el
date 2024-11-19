;;; init-sis.el --- Emacs-Smart-Input-Source -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(maybe-require-package 'sis)

(sis-ism-lazyman-config
 "com.apple.keylayout.ABC"
 "com.apple.inputmethod.SCIM.ITABC")

(sis-global-cursor-color-mode t)
(setq sis-other-cursor-color "red")

(sis-global-respect-mode t)
(sis-global-context-mode t)
(sis-global-inline-mode t)

(provide 'init-sis)

;;; init-sis.el ends here.
