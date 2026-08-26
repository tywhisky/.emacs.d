;;; init-lsp-update-test.el --- Checks for init-lsp-update -*- lexical-binding: t -*-

(require 'ert)
(require 'init-lsp-update)

(ert-deftest lsp-update-managed-download-is-contained-and-verified ()
  (let* ((lsp-update-directory (make-temp-file "lsp-update-test-" t))
         (properties '(:asset "server"))
         (file (expand-file-name "download" lsp-update-directory)))
    (unwind-protect
        (progn
          (with-temp-file file (insert "expert"))
          (should (equal (lsp-update--managed-target properties)
                         (expand-file-name "server" lsp-update-directory)))
          (should-not
           (lsp-update--verify-digest
            file
            (concat "sha256:"
                    (secure-hash 'sha256 "expert"))))
          (should-error (lsp-update--verify-digest file "sha256:00")))
      (delete-directory lsp-update-directory t))))

(ert-deftest lsp-update-command-release-properties ()
  (let ((properties
         '(:tag-prefix "gopls/v"
           :executable "gopls"
           :install-command
           (lambda (version) (list "go" "install" version)))))
    (should (equal (lsp-update--latest-version
                    '((tag_name . "gopls/v0.23.0")) properties)
                   "0.23.0"))
    (should (equal (lsp-update--install-command properties "0.23.0")
                   '("go" "install" "0.23.0")))))

;;; init-lsp-update-test.el ends here
