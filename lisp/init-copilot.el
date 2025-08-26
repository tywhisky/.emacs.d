;;; init-copilot.el --- Copilot -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require 'copilot)

(with-eval-after-load 'copilot
  (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "C-<tab>") 'copilot-accept-completion-by-word)
  (define-key copilot-completion-map (kbd "C-TAB") 'copilot-accept-completion-by-word)
  (define-key copilot-completion-map (kbd "C-n") 'copilot-next-completion)
  (define-key copilot-completion-map (kbd "C-p") 'copilot-previous-completion))

(add-to-list 'copilot-indentation-alist '(elixir-ts-mode 2))
(add-to-list 'copilot-indentation-alist '(typescript-ts-mode 2))
(add-to-list 'copilot-indentation-alist '(text-mode 2))
(add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2))

(add-hook 'typescript-ts-mode-hook #'copilot-mode)
(add-hook 'elixir-ts-mode-hook #'copilot-mode)
(add-hook 'text-mode-hook #'copilot-mode)
(add-hook 'emacs-lisp-mode-hook #'copilot-mode)

(provide 'init-copilot)
;;; init-copilot.el ends here
