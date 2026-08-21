;;; init-git.el --- Git SCM support -*- lexical-binding: t -*-
;;; Commentary:

;; See also init-github.el.

;;; Code:

(require-package 'git-modes)
(maybe-require-package 'magit)
(setq magit-auto-revert-mode t)
(add-hook 'magit-mode-hook
          (lambda () (setq left-fringe-width 24)))

(when (maybe-require-package 'diff-hl)
  (setq diff-hl-margin-symbols-alist
        '((insert . " ") (delete . " ") (change . " ")
          (unknown . "?") (ignored . "i") (reference . " ")))
  (add-hook 'diff-hl-mode-on-hook
            (lambda () (setq-local left-margin-width 1)))
  (global-diff-hl-mode 1)
  (diff-hl-margin-mode 1)
  (diff-hl-flydiff-mode 1)
  (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh))

(provide 'init-git)
;;; init-git.el ends here
