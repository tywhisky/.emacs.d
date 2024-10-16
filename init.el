;; -*- lexical-binding: t -*-

;; Load the `lisp` directory
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Set the custom path to prevent the package-selected-packages generate in init.el
(setq custom-file (locate-user-emacs-file "custom.el"))
;; Common
(require 'init-utils)
(require 'init-elpa)

(require 'init-gui-frames)
(require 'init-key-mapping)
(require 'init-themes)
(require 'init-modeline)
(require 'init-minibuffer)
(require 'init-markdown)
(require 'init-corfu)
(require 'init-snippet)
(require 'init-eglot)
(require 'init-git)
(require 'init-terminals)
(require 'init-projectile)
(require 'init-spelling)
(require 'init-treesitter)

;; Languages
(require 'init-erlang)
(require 'init-elixir)
(require 'init-javascript)

