;; -*- lexical-binding: t -*-

;; Load the `lisp` directory
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;; Set the custom path to prevent the package-selected-packages generate in init.el
(setq custom-file (locate-user-emacs-file "custom.el"))


;; Core
(require 'init-utils)
(require 'init-elpa)
(require 'init-exec-path)


;; UI & Appearance
(require 'init-editing-utils)
(require 'init-gui-frames)
(require 'init-themes)
(require 'init-modeline)
(require 'init-minibuffer)
(require 'init-ibuffer)


;; Editing Enhancements
(require 'init-key-mapping)
(require 'init-markdown)
(require 'init-corfu)
(require 'init-snippet)
(require 'init-spelling)
(require 'init-treesitter)
(require 'init-sis)


;; Development Tools
(require 'init-eglot)
(require 'init-git)
(require 'init-terminals)
(require 'init-projectile)
(require 'init-docker)


;; External Features
(require 'init-elfeed)


;; Language-Specific Configurations
(require 'init-erlang)
(require 'init-elixir)
(require 'init-javascript)
(require 'init-golang)
