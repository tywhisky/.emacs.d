;;; init-eglot.el --- LSP support via eglot          -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

(maybe-require-package 'consult-eglot)

(with-eval-after-load 'eglot
  (setf (alist-get '(csharp-mode csharp-ts-mode)
                   eglot-server-programs nil nil #'equal)
        '("~/.language-servers/dotnet/OmniSharp" "-lsp")))

(add-hook 'typescript-ts-mode-hook 'eglot-ensure)
(add-hook 'csharp-mode-hook 'eglot-ensure)
(add-hook 'csharp-ts-mode-hook 'eglot-ensure)
(add-hook 'haskell-mode-hook 'eglot-ensure)

(provide 'init-eglot)
;;; init-eglot.el ends here
