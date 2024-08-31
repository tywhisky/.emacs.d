;; -*- lexical-binding: t -*-

;; Load the `lisp` directory
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Set the custom path to prevent the package-selected-packages generate in init.el
(setq custom-file (locate-user-emacs-file "custom.el"))
;; Common
(require 'init-utils)
(require 'init-elpa)

(require 'init-gui-frames)
(require 'init-themes)
(require 'init-modeline)
(require 'init-minibuffer)
(require 'init-markdown)
(require 'init-corfu)
(require 'init-eglot)
(require 'init-git)
(require 'init-terminals)

;; Languages
(require 'init-elixir)
