;;; init-golang.el --- Support for Golang          -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(require 'init-lsp-update)

(lsp-update-register
 'gopls
 :repository "golang/tools"
 :tag-prefix "gopls/v"
 :executable "gopls"
 :install-command
 (lambda (version)
   (list "env"
         (concat "GOBIN=" (directory-file-name lsp-update-directory))
         "go" "install"
         (format "golang.org/x/tools/gopls@v%s" version)))
 :version-arguments '("version")
 :version-regexp "gopls v\\([0-9.]+\\)")

(with-eval-after-load 'eglot
  (setf (alist-get '(go-mode go-dot-mod-mode go-dot-work-mode
                             go-ts-mode go-mod-ts-mode go-work-ts-mode)
                   eglot-server-programs nil nil #'equal)
        `(,(lsp-update-executable 'gopls))))

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
(add-hook 'go-ts-mode-hook #'eglot-ensure)

(provide 'init-golang)
;;; init-golang.el ends here
