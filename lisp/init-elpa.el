;;; init-elpa.el --- Settings and helpers for package.el -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require 'package)
(require 'cl-lib)


;; TNUA ELPA
;; (add-to-list 'package-archives '("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/") t)
;; (add-to-list 'package-archives '("melpa" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/") t)
;; (add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)

;;; Standard package repositories
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(add-to-list 'package-unsigned-archives "melpa")



;;; On-demand installation of packages

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (when (stringp min-version)
    (setq min-version (version-to-list min-version)))
  (or (package-installed-p package min-version)
      (let* ((known (cdr (assoc package package-archive-contents)))
             (best (car (sort known (lambda (a b)
                                      (version-list-<= (package-desc-version b)
                                                       (package-desc-version a)))))))
        (if (and best (version-list-<= min-version (package-desc-version best)))
            (package-install best)
          (if no-refresh
              (error "No version of %s >= %S is available" package min-version)
            (package-refresh-contents)
            (require-package package min-version t)))
        (package-installed-p package min-version))))

(defun maybe-require-package (package &optional min-version no-refresh)
  "Try to install PACKAGE, and return non-nil if successful.
In the event of failure, return nil and print a warning message.
Optionally require MIN-VERSION.  If NO-REFRESH is non-nil, the
available package lists will not be re-downloaded in order to
locate PACKAGE."
  (condition-case err
      (require-package package min-version no-refresh)
    (error
     (message "Couldn't install optional package `%s': %S" package err)
     nil)))

(setq package-native-compile t)

;; `custom.el' is intentionally untracked, so keep the direct package roots
;; here.  This makes `package-autoremove' safe after a fresh installation.
(customize-set-variable
 'package-selected-packages
 '(avy beacon consult consult-eglot corfu dhall-mode diff-hl docker
   doom-modeline doric-themes eat elfeed embark embark-consult erlang
   exec-path-from-shell flymake-ruff git-modes gptel haskell-mode
   ibuffer-vc js-comint magit marginalia markdown-mode mise mode-line-bell
   moom move-dup multiple-cursors nerd-icons orderless page-break-lines
   pip-requirements rainbow-delimiters reformatter ruff-format
   spacious-padding symbol-overlay unfill vertico vlf whole-line-or-region
   yasnippet yasnippet-snippets))

(provide 'init-elpa)
;;; init-elpa.el ends here
