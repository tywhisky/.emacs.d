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

  (setq eat-term-name "xterm-256color")

  (with-eval-after-load 'eat
    (custom-set-variables
     `(eat-semi-char-non-bound-keys
       (quote ,(cons [?\e ?w] eat-semi-char-non-bound-keys)))))

  (global-set-key (kbd "C-c t") 'eat-other-window))

;; Install the exec-path-from-shell
(maybe-require-package 'exec-path-from-shell)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(provide 'init-terminals)
;;; init-terminals.el ends here
