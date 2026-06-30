;;; init-exec-path.el --- Set up exec-path to help Emacs find programs  -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require-package 'exec-path-from-shell)

(with-eval-after-load 'exec-path-from-shell
  (dolist (var '("SSH_AUTH_SOCK"
		 "SSH_AGENT_PID"
		 "GPG_AGENT_INFO"
		 "LANG"
		 "LC_CTYPE"
                 "DOTNET_ROOT"
		 "NIX_SSL_CERT_FILE"
		 "NIX_PATH"))
    (add-to-list 'exec-path-from-shell-variables var)))


(when (or (memq window-system '(mac ns x pgtk))
          (unless (memq system-type '(ms-dos windows-nt))
            (daemonp)))
  (exec-path-from-shell-initialize))

(unless (getenv "DOTNET_ROOT")
  (let* ((dotnet (executable-find "dotnet"))
         (root (and dotnet
                    (directory-file-name
                     (file-name-directory (file-truename dotnet)))))
         (default-root "/usr/local/share/dotnet"))
    (cond
     ((and root (file-directory-p (expand-file-name "sdk" root)))
      (setenv "DOTNET_ROOT" root))
     ((file-directory-p (expand-file-name "sdk" default-root))
      (setenv "DOTNET_ROOT" default-root)))))

(provide 'init-exec-path)
;;; init-exec-path.el ends here
