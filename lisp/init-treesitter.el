;;; init-treesitter.el --- Enable Tree-sitter modes -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Emacs 31 selects an available Tree-sitter mode and offers to install a
;; missing grammar when the mode is entered.
(customize-set-variable 'treesit-enabled-modes t)
(setq treesit-font-lock-level 4
      treesit-language-source-alist
      '((bash "https://github.com/tree-sitter/tree-sitter-bash")
        (csharp "https://github.com/tree-sitter/tree-sitter-c-sharp")
        (css "https://github.com/tree-sitter/tree-sitter-css")
        (dockerfile "https://github.com/camdencheek/tree-sitter-dockerfile")
        (elisp "https://github.com/Wilfred/tree-sitter-elisp")
        (elixir "https://github.com/elixir-lang/tree-sitter-elixir.git")
        (go "https://github.com/tree-sitter/tree-sitter-go")
        (gomod "https://github.com/camdencheek/tree-sitter-go-mod.git")
        (heex "https://github.com/phoenixframework/tree-sitter-heex.git")
        (html "https://github.com/tree-sitter/tree-sitter-html")
        (javascript "https://github.com/tree-sitter/tree-sitter-javascript")
        (json "https://github.com/tree-sitter/tree-sitter-json")
        (lua "https://github.com/Azganoth/tree-sitter-lua")
        (make "https://github.com/alemuller/tree-sitter-make")
        (markdown "https://github.com/MDeiml/tree-sitter-markdown" nil
                  "tree-sitter-markdown/src")
        (ocaml "https://github.com/tree-sitter/tree-sitter-ocaml" nil
               "ocaml/src")
        (org "https://github.com/milisims/tree-sitter-org")
        (python "https://github.com/tree-sitter/tree-sitter-python")
        (ruby "https://github.com/tree-sitter/tree-sitter-ruby")
        (rust "https://github.com/tree-sitter/tree-sitter-rust")
        (sql "https://github.com/m-novikov/tree-sitter-sql")
        (toml "https://github.com/tree-sitter/tree-sitter-toml")
        (tsx "https://github.com/tree-sitter/tree-sitter-typescript" nil
             "tsx/src")
        (typescript "https://github.com/tree-sitter/tree-sitter-typescript" nil
                    "typescript/src")
        (vue "https://github.com/merico-dev/tree-sitter-vue")
        (yaml "https://github.com/ikatyang/tree-sitter-yaml")
        (zig "https://github.com/GrayJack/tree-sitter-zig")))

(provide 'init-treesitter)
;;; init-treesitter.el ends here
