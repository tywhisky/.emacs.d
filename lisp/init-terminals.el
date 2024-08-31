;;; init-terminals.el --- Terminal emulators          -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(when (maybe-require-package 'eat)
  (defun sanityinc/on-eat-exit (process)
    (when (zerop (process-exit-status process))
      (kill-buffer)
      (unless (eq (selected-window) (next-window))
        (delete-window))))
  (add-hook 'eat-exit-hook 'sanityinc/on-eat-exit)

  (with-eval-after-load 'eat
    (custom-set-variables
     `(eat-semi-char-non-bound-keys
       (quote ,(cons [?\e ?w] eat-semi-char-non-bound-keys)))))


  (global-set-key (kbd "C-c t") 'eat-other-window))

(provide 'init-terminals)
