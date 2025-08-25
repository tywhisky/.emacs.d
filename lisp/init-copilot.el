;;; init-copilot.el --- Copilot -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require 'copilot)

(copilot-mode 1)

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

(provide 'init-copilot)
;;; init-copilot.el ends here
