;;; init-git.el --- Git SCM support -*- lexical-binding: t -*-
;;; Commentary:

;; See also init-github.el.

;;; Code:

(require-package 'git-modes)
(maybe-require-package 'magit)
(setq magit-auto-revert-mode t)

(provide 'init-git)
;;; init-git.el ends here
