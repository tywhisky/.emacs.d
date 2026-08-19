;;; init-elixir.el --- Support for Elixir          -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(maybe-require-package 'elixir-ts-mode)
(require 'init-lsp-update)

(lsp-update-register
 'expert
 :repository "expert-lsp/expert"
 :directory (expand-file-name "~/.language-servers/elixir/")
 :asset (lambda ()
          (format "expert_%s_%s"
                  (lsp-update-os)
                  (lsp-update-architecture)))
 :version-regexp "\"app_version\":\"\\([^\"]+\\)\"")

(let ((lang-server (expand-file-name "~/.language-servers/elixir")))
  (setenv "PATH" (concat lang-server path-separator (getenv "PATH")))
  (add-to-list 'exec-path lang-server))

(with-eval-after-load 'eglot
  (setf (alist-get '(elixir-mode elixir-ts-mode heex-ts-mode)
                   eglot-server-programs
                   nil nil #'equal)
        (eglot-alternatives
         `((,(file-name-nondirectory (lsp-update-executable 'expert))
            "--stdio")
           "start_lexical.sh"))))

(add-hook 'elixir-ts-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'eglot-format nil t)))

(add-hook 'elixir-ts-mode-hook 'eglot-ensure)

(provide 'init-elixir)
;;; init-elixir.el ends here
