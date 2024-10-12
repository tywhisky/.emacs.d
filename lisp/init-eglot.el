;;; init-eglot.el --- LSP support via eglot          -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(when (maybe-require-package 'eglot)
  (maybe-require-package 'consult-eglot))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '(elixir-mode "~/.config/emacs/language-server/elixir/release/language_server.sh"))
  (add-to-list 'eglot-server-programs
               '((js-ts-mode typescript-ts-mode tsx-ts-mode)
                 "typescript-language-server" "--stdio")))

(add-hook 'elixir-mode-hook 'eglot-ensure)
(add-hook 'typescript-mode-hook 'eglot-ensure)

(provide 'init-eglot)
;;; init-eglot.el ends here
