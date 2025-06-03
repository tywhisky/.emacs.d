;;; init-gpt.el --- LLM Chat Client -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(maybe-require-package 'chatgpt-shell)

(setq chatgpt-shell-deepseek-key
      (auth-source-pick-first-password :host "api.deepseek.com"))

(setq chatgpt-shell-google-key
      (auth-source-pick-first-password :host "generativelanguage.googleapis.com"))

(provide 'init-gpt)
;;; init-gpt.el ends here
