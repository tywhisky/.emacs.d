;;; init-modeline.el --- Custom native modeline -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Enable line and column numbers in the modeline
(line-number-mode 1)
(column-number-mode 1)

;; Remove the box around the modeline
(set-face-attribute 'mode-line nil :box nil)

;; Font settings for modeline
(let ((family "Lilex Nerd Font Mono")
      (slant 'italic)
      (height 0.95)
      (weight 'light)
      (box nil))
  (custom-set-faces
   `(mode-line ((t (:family ,family :slant ,slant :height ,height :weight ,weight :box ,box))))
   `(mode-line-inactive ((t (:family ,family :slant ,slant :height ,height :weight ,weight :box ,box))))))

;; Custom modeline format
(setq-default mode-line-format
              '("%e"
                mode-line-front-space
                ;; buffer modified status
                (:eval (if (buffer-modified-p) "● " "  "))
                ;; buffer name
                mode-line-buffer-identification
                "   "
                ;; major mode
                mode-line-modes
                "   "
                ;; position: line:column
                (:eval (format "%l:%c"))
                "   "
                ;; file encoding
                mode-line-mule-info
                mode-line-end-spaces))

(provide 'init-modeline)
;;; init-modeline.el ends here
