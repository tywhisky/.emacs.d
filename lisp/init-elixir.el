;;; init-elixir.el --- Support for Elixir          -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(maybe-require-package 'elixir-mode)

(add-hook 'elixir-mode-hook 'eglot-ensure)

(provide 'init-elixir)
