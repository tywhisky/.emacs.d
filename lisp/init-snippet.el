;;; init-git.el --- Git SCM support -*- lexical-binding: t -*-
;;; Commentary:

;; See also init-github.el.

;;; Code:

(when (maybe-require-package 'yasnippet)
  (yas-global-mode 1)
  (maybe-require-package 'yasnippet-snippets))

(provide 'init-snippet)
