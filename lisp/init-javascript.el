;;; init-javascript.el --- JavaScript support -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setq-default js-indent-level 2)

;; Run and interact with Node through js-comint.
(when (maybe-require-package 'js-comint)
  (setq js-comint-program-command "node")

  (defvar inferior-js-minor-mode-map
    (let ((map (make-sparse-keymap)))
      (define-key map (kbd "C-x C-e") #'js-send-last-sexp)
      (define-key map (kbd "C-c b") #'js-send-buffer)
      map))

  (define-minor-mode inferior-js-keys-mode
    "Bindings for communicating with an inferior JavaScript interpreter."
    :lighter " InfJS"
    :keymap inferior-js-minor-mode-map)

  (dolist (hook '(js-mode-hook js-ts-mode-hook
                  typescript-ts-mode-hook tsx-ts-mode-hook))
    (add-hook hook #'inferior-js-keys-mode)))

(provide 'init-javascript)
;;; init-javascript.el ends here
