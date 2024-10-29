;;; init-golang.el --- Support for Golang          -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(maybe-require-package 'go-ts-mode)

;; Find the go.mod as the project root.
(defun project-find-go-module (dir)
  (when-let ((root (locate-dominating-file dir "go.mod")))
    (cons 'go-module root)))

(cl-defmethod project-root ((project (head go-module)))
  (cdr project))

(add-hook 'project-find-functions #'project-find-go-module)

(provide 'init-golang)
;;; init-golang.el ends here
