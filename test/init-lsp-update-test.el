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

;;; init-lsp-update-test.el ends here
