;;; init-chat.el --- LLM Chat Client -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(maybe-require-package 'gptel)

;; Set Copilot as default model
(setq gptel-model 'claude-3.7-sonnet
      gptel-backend (gptel-make-gh-copilot "Copilot"))

(setq gptel-api-key (auth-source-pick-first-password :host "openai"))

(gptel-make-deepseek "DeepSeek"       
  :stream t                           
  :key (auth-source-pick-first-password :host "deepseek"))

(gptel-make-deepseek "Gemini"       
  :stream t                           
  :key (auth-source-pick-first-password :host "gemini"))


(global-set-key (kbd "C-c <return>") 'gptel-send)

(provide 'init-chat)
;;; init-chat.el ends here
