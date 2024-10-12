;;; init-elixir.el --- Support for Elixir          -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(maybe-require-package 'elixir-mode)

(add-hook 'elixir-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'elixir-format nil t)))

(provide 'init-elixir)
