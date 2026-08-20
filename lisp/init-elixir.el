;;; init-elixir.el --- Support for Elixir          -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(require 'init-lsp-update)

(lsp-update-register
 'expert
 :repository "expert-lsp/expert"
 :asset (lambda ()
          (format "expert_%s_%s"
                  (lsp-update-os)
                  (lsp-update-architecture)))
 :version-regexp "\"app_version\":\"\\([^\"]+\\)\"")

(with-eval-after-load 'eglot
  (setf (alist-get '(elixir-mode elixir-ts-mode heex-ts-mode)
                   eglot-server-programs
                   nil nil #'equal)
        (eglot-alternatives
         `((,(lsp-update-executable 'expert) "--stdio")
           "start_lexical.sh"))))

(defun tywhisky/elixir-format-buffer-maybe ()
  "Format the current Elixir buffer when Eglot manages it."
  (when (eglot-managed-p)
    (eglot-format-buffer)))

(add-hook 'elixir-ts-mode-hook
          (lambda ()
            (add-hook 'before-save-hook
                      #'tywhisky/elixir-format-buffer-maybe nil t)))

(add-hook 'elixir-ts-mode-hook 'eglot-ensure)

(provide 'init-elixir)
;;; init-elixir.el ends here
