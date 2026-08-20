;;; init-python.el --- Python editing -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
                ("SConscript\\'" . python-mode))
              auto-mode-alist))

(setq python-shell-interpreter "python3")

(require-package 'pip-requirements)

(when (maybe-require-package 'flymake-ruff)
  (defun sanityinc/flymake-ruff-maybe-enable ()
    (when (executable-find "ruff")
      (flymake-ruff-load)))
  (add-hook 'python-base-mode-hook 'sanityinc/flymake-ruff-maybe-enable))

(maybe-require-package 'ruff-format)

(add-to-list 'auto-mode-alist '("\\(poetry\\|uv\\)\\.lock\\'" . toml-ts-mode))

(with-eval-after-load 'project
  (add-to-list 'project-vc-extra-root-markers "pyproject.toml"))

(provide 'init-python)
;;; init-python.el ends here
