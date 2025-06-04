;;; init-gpt.el --- LLM Chat Client -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(maybe-require-package 'gptel)

;; Gemini as default model
(setq gptel-model 'gemini-2.5-flash-preview-05-20
          gptel-backend (gptel-make-gemini "Gemini"
                                           :key (auth-source-pick-first-password :host "gemini")
                                           :stream t)
          gptel-use-curl nil)

(setq gptel-api-key (auth-source-pick-first-password :host "openai"))

(gptel-make-deepseek "DeepSeek"       
  :stream t                           
  :key (auth-source-pick-first-password :host "deepseek"))

(global-set-key (kbd "C-c <return>") 'gptel-send)

(provide 'init-gpt)
;;; init-gpt.el ends here
