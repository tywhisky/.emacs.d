;;; init-elixir.el --- Support for Elixir          -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(maybe-require-package 'elixir-mode)
(maybe-require-package 'elixir-ts-mode)

(add-hook 'elixir-ts-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'eglot-format nil t)))

(provide 'init-elixir)
;;; init-elixir.el ends here
