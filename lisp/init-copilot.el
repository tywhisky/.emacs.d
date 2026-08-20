;;; init-copilot.el --- Copilot -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(autoload 'copilot-mode "copilot" nil t)

(defun my/copilot-chat-insert-commit-message ()
  "Generate a commit message with Copilot Chat."
  (interactive)
  (require 'copilot-chat)
  (copilot-chat-insert-commit-message))

(with-eval-after-load 'git-commit
  (define-key git-commit-mode-map (kbd "C-c C-g")
              #'my/copilot-chat-insert-commit-message))

(with-eval-after-load 'copilot
  (define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)
  (define-key copilot-completion-map (kbd "C-<tab>") 'copilot-accept-completion-by-word)
  (define-key copilot-completion-map (kbd "C-TAB") 'copilot-accept-completion-by-word)
  (define-key copilot-completion-map (kbd "C-n") 'copilot-next-completion)
  (define-key copilot-completion-map (kbd "C-p") 'copilot-previous-completion)

  (add-to-list 'copilot-indentation-alist '(elixir-ts-mode 2))
  (add-to-list 'copilot-indentation-alist '(typescript-ts-mode 2))
  (add-to-list 'copilot-indentation-alist '(text-mode 2))
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2)))

(defun my/copilot-mode ()
  "Toggle Copilot in the current buffer, loading it on demand."
  (interactive)
  (require 'copilot)
  (call-interactively #'copilot-mode))

(provide 'init-copilot)
;;; init-copilot.el ends here
