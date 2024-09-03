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

  (defun sanityinc/eat-window-on-current-path ()
    "Run `eat-other-window` and cd to current path."
    (interactive)
    (let ((current-dir (file-name-directory (buffer-file-name))))
      (eat-other-window)
      (run-at-time 0.1 nil
		   (lambda ()
                     (eat-term-send-string eat-terminal (concat "cd " current-dir))
                     (eat-term-send-string eat-terminal "\r")))))

  (global-set-key (kbd "C-c t") 'sanityinc/eat-window-on-current-path))

(provide 'init-terminals)
