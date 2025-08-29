;;; init-elixir.el --- Support for Elixir          -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(maybe-require-package 'elixir-ts-mode)

(let ((lang-server (expand-file-name "~/.language-servers/elixir")))
  (setenv "PATH" (concat lang-server path-separator (getenv "PATH")))
  (add-to-list 'exec-path lang-server))

(with-eval-after-load 'eglot
  (setf (alist-get '(elixir-mode elixir-ts-mode heex-ts-mode)
                   eglot-server-programs
                   nil nil #'equal)
        (if (and (fboundp 'w32-shell-dos-semantics)
                 (w32-shell-dos-semantics))
            '("expert_darwin_arm64")
          (eglot-alternatives
           '("expert_darwin_arm64" "start_lexical.sh")))))

(add-hook 'elixir-ts-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'eglot-format nil t)))

(add-hook 'elixir-ts-mode-hook 'eglot-ensure)

(provide 'init-elixir)
;;; init-elixir.el ends here
