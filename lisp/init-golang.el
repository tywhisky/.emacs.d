;;; init-golang.el --- Support for Golang          -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(defun tywhisky/setup-go-indentation ()
  "Use Go's conventional tab indentation."
  (setq-local indent-tabs-mode t)
  (setq-local tab-width 2))

(add-hook 'go-mode-hook #'tywhisky/setup-go-indentation)
(add-hook 'go-ts-mode-hook #'tywhisky/setup-go-indentation)

;; Find the go.mod as the project root.
(defun project-find-go-module (dir)
  (when-let* ((root (locate-dominating-file dir "go.mod")))
    (cons 'go-module root)))

(cl-defmethod project-root ((project (head go-module)))
  (cdr project))

(add-hook 'project-find-functions #'project-find-go-module)

(provide 'init-golang)
;;; init-golang.el ends here
