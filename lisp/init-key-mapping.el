;;; init-key-mapping.el --- Key Mapping for MacOS -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; Change META key on MacOS
(setq mac-command-modifier      'meta
      mac-option-modifier       'alt
      mac-right-option-modifier 'alt)


;; Avoid accidentally suspending Emacs.
(global-unset-key (kbd "C-z"))


;; Rebind <C-[> (ESC) to C-g (keyboard-quit)
(defun setup-input-decode-map ()
  (define-key input-decode-map (kbd "C-[") (kbd "C-g")))

(setup-input-decode-map)
(add-hook 'tty-setup-hook #'setup-input-decode-map)

(provide 'init-key-mapping)
;;; init-key-mapping.el ends here
