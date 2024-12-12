;;; init-dirvish.el --- Dired customisations -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(when (maybe-require-package 'dirvish)
  (dirvish-override-dired-mode)
  (global-set-key (kbd "C-c f") 'dirvish))

(provide 'init-dirvish)
;;; init-dirvish.el ends here
