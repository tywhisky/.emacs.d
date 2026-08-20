;;; init-chat.el --- LLM Chat Client -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(when (maybe-require-package 'gptel)
  (setq gptel-model 'claude-sonnet-4.6
        gptel-backend (gptel-make-gh-copilot "Copilot"))

  (gptel-make-deepseek "DeepSeek"
    :stream t
    :key (auth-source-pick-first-password :host "deepseek"))

  (gptel-make-gemini "Gemini"
    :stream t
    :key (auth-source-pick-first-password :host "gemini"))

  (global-set-key (kbd "C-c <return>") #'gptel-send))

(provide 'init-chat)
;;; init-chat.el ends here
