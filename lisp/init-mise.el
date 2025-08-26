;;; init-mise.el --- Integration for mise -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(maybe-require-package 'mise)

(add-hook 'after-init-hook #'global-mise-mode)

(provide 'init-mise)
;;; init-mise.el ends here
