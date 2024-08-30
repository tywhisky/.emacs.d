;;; init-utils.el --- Elisp helper functions and commands -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Handier way to add modes to auto-mode-alist
(defun add-auto-mode (mode &rest patterns)
  "Add entries to `auto-mode-alist' to use `MODE' for all given file `PATTERNS'."
  (dolist (pattern patterns)
    (add-to-list 'auto-mode-alist (cons pattern mode))))

;; Open my `init.el`
(defun my/init-file ()
  "Open the init file."
  (interactive)
  (find-file user-init-file))

(provide 'init-utils)
