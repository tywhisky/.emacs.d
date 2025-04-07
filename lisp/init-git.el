;;; init-git.el --- Git SCM support -*- lexical-binding: t -*-
;;; Commentary:

;; See also init-github.el.

;;; Code:

(require-package 'git-modes)
(maybe-require-package 'magit)
(setq magit-auto-revert-mode t)

(maybe-require-package 'blamer)
(global-blamer-mode 1)

(setq blamer-idle-time 0.3
      blamer-min-offset 70
      blamer-type 'visual)

(set-face-attribute 'blamer-face nil
                    :foreground "#7a88cf"
                    :background nil
                    :height 140
                    :italic t)

(global-set-key (kbd "s-i") 'blamer-show-commit-info)
(global-set-key (kbd "C-c C-i") 'blamer-show-posframe-commit-info)

(provide 'init-git)
;;; init-git.el ends here
