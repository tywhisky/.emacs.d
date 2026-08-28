;;; init-python.el --- Python editing -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
                ("SConscript\\'" . python-mode))
              auto-mode-alist))

(setq python-shell-interpreter "python3")

(require-package 'pip-requirements)

(require 'init-lsp-update)

(lsp-update-register
 'basedpyright
 :repository "detachhead/basedpyright"
 :executable "basedpyright"
 :install-command
 (lambda (version)
   (list "env"
         (concat "UV_TOOL_DIR="
                 (expand-file-name ".uv-tools" lsp-update-directory))
         (concat "UV_TOOL_BIN_DIR="
                 (directory-file-name lsp-update-directory))
         "uv" "tool" "install" "--force"
         (format "basedpyright==%s" version)))
 :version-arguments '("--version")
 :version-regexp "basedpyright \\([0-9.]+\\)")

(with-eval-after-load 'eglot
  (let ((basedpyright (lsp-update-executable 'basedpyright)))
    (setf (alist-get '(python-mode python-ts-mode)
                     eglot-server-programs nil nil #'equal)
          `(,(expand-file-name "basedpyright-langserver"
                               (file-name-directory basedpyright))
            "--stdio"))))

(add-hook 'python-base-mode-hook #'eglot-ensure)

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
