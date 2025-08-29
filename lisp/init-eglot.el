;;; init-eglot.el --- LSP support via eglot          -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(when (maybe-require-package 'eglot)
  (maybe-require-package 'consult-eglot))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs '((js-ts-mode typescript-ts-mode) "typescript-language-server" "--stdio"))
  (add-to-list 'eglot-server-programs '(go-ts-mode "gopls"))
  (add-to-list 'eglot-server-programs '(csharp-mode "~/.language-servers/dotnet/OmniSharp" "-lsp")))

(add-hook 'typescript-ts-mode-hook 'eglot-ensure)
(add-hook 'go-ts-mode-hook 'eglot-ensure)
(add-hook 'csharp-mode 'eglot-ensure)

(provide 'init-eglot)
;;; init-eglot.el ends here
