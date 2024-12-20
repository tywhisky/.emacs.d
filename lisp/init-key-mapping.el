;;; init-key-mapping.el --- Key Mapping for MacOS -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setq mac-command-modifier      'meta
      mac-option-modifier       'alt
      mac-right-option-modifier 'alt)

;; Rebind the 'suspend-frame especially on WSL
(global-set-key (kbd "C-x 5") 'suspend-frame)
(global-unset-key (kbd "C-z"))

(provide 'init-key-mapping)
;;; init-key-mapping.el ends here
