;;; init-gpt.el --- LLM Chat Client -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(maybe-require-package 'gptel)

(setq gptel-api-key (auth-source-pick-first-password :host "openai"))
(gptel-make-gemini "Gemini" :key (auth-source-pick-first-password :host "gemini") :stream t)
(gptel-make-deepseek "DeepSeek"       
  :stream t                           
  :key (auth-source-pick-first-password :host "deepseek"))  

(provide 'init-gpt)
;;; init-gpt.el ends here
