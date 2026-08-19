;;; init-lsp-update.el --- Update language-server binaries  -*- lexical-binding: t; -*-
;;; Commentary:
;; Register GitHub-hosted language-server binaries, check them after startup,
;; and replace an installed binary only after its download succeeds.
;;; Code:

(require 'json)
(require 'seq)
(require 'subr-x)
(require 'tabulated-list)
(require 'url)
(require 'url-http)

(defgroup lsp-update nil
  "Update language-server binaries."
  :group 'tools)

(defcustom lsp-update-startup-delay 5
  "Idle seconds before checking registered language servers."
  :type 'number)

(defconst lsp-update-directory
  (locate-user-emacs-file "var/language-servers/")
  "Directory containing managed language-server binaries.")

(defvar lsp-update-servers nil
  "Alist of registered language servers and their properties.")

(defun lsp-update-os ()
  "Return the release-asset OS name for this system."
  (pcase system-type
    ('darwin "darwin")
    ('gnu/linux "linux")
    ('windows-nt "windows")
    (_ (error "Unsupported system: %s" system-type))))

(defun lsp-update-architecture ()
  "Return the release-asset architecture name for this system."
  (cond
   ((string-match-p "aarch64\\|arm64" system-configuration) "arm64")
   ((string-match-p "x86_64\\|amd64" system-configuration) "amd64")
   (t (error "Unsupported architecture: %s" system-configuration))))

(defun lsp-update-register (name &rest properties)
  "Register language server NAME with PROPERTIES.

Required properties are :repository and :asset.  :ASSET may
be a release filename or a function returning one.  Optional :executable
renames the downloaded file, :version-regexp reads an unmanaged binary's
version, and :min-size sets the minimum accepted download size in bytes."
  (setf (alist-get name lsp-update-servers) properties))

(defun lsp-update--property (properties key)
  "Return KEY from PROPERTIES, or signal a useful configuration error."
  (or (plist-get properties key)
      (error "Missing language-server property %s" key)))

(defun lsp-update--asset (properties)
  "Return the release asset name described by PROPERTIES."
  (let ((asset (lsp-update--property properties :asset)))
    (if (functionp asset) (funcall asset) asset)))

(defun lsp-update-executable (name)
  "Return the managed executable path for server NAME."
  (let* ((properties (alist-get name lsp-update-servers))
         (executable (or (plist-get properties :executable)
                         (lsp-update--asset properties)))
         (managed (seq-find
                   #'file-executable-p
                   (cons (expand-file-name executable lsp-update-directory)
                         (file-expand-wildcards
                          (expand-file-name (concat "*/" executable)
                                            lsp-update-directory)
                          t)))))
    (or managed
        (executable-find executable)
        (expand-file-name executable lsp-update-directory))))

(defun lsp-update--version-file (name)
  "Return NAME's version-file path."
  (expand-file-name (format ".%s-version" name)
                    (file-name-directory (lsp-update-executable name))))

(defun lsp-update--local-version (name properties)
  "Return NAME's installed version using PROPERTIES, or nil."
  (let ((version-file (lsp-update--version-file name))
        (executable (lsp-update-executable name))
        (regexp (plist-get properties :version-regexp)))
    (cond
     ((file-readable-p version-file)
      (string-trim (with-temp-buffer
                     (insert-file-contents version-file)
                     (buffer-string))))
     ((and regexp (file-readable-p executable))
      (with-temp-buffer
        (set-buffer-multibyte nil)
        (insert-file-contents-literally executable)
        (when (re-search-forward regexp nil t)
          (match-string 1)))))))

(defun lsp-update--response-body ()
  "Move point to the current URL buffer's response body."
  (unless (and (boundp 'url-http-response-status)
               (eq url-http-response-status 200))
    (error "HTTP request failed with status %s"
           (and (boundp 'url-http-response-status)
                url-http-response-status)))
  (goto-char (point-min))
  (unless (re-search-forward "\r?\n\r?\n" nil t)
    (error "Malformed HTTP response")))

(defun lsp-update--release ()
  "Parse a GitHub release from the current URL buffer."
  (lsp-update--response-body)
  (let ((json-object-type 'alist)
        (json-array-type 'list)
        (json-key-type 'symbol))
    (json-read)))

(defun lsp-update--asset-url (release asset-name)
  "Return ASSET-NAME's download URL from RELEASE."
  (when-let* ((asset (seq-find
                      (lambda (candidate)
                        (equal (alist-get 'name candidate) asset-name))
                      (alist-get 'assets release))))
    (alist-get 'browser_download_url asset)))

(defun lsp-update--check-callback (status name properties)
  "Handle NAME's release response described by STATUS and PROPERTIES."
  (unwind-protect
      (if-let* ((failure (plist-get status :error)))
          (message "%s update check failed: %s" name failure)
        (condition-case err
            (let* ((release (lsp-update--release))
                   (latest (string-remove-prefix
                            "v" (alist-get 'tag_name release)))
                   (local (lsp-update--local-version name properties))
                   (asset (lsp-update--asset properties))
                   (url (lsp-update--asset-url release asset)))
              (unless url
                (error "Release %s has no %s asset" latest asset))
              (when (or (null local) (version< local latest))
                (run-at-time 0 nil #'lsp-update--offer
                             name properties local latest url)))
          (error (message "%s update check failed: %s" name
                          (error-message-string err)))))
    (kill-buffer (current-buffer))))

(defun lsp-update--offer (name properties local latest url)
  "Offer to update NAME from LOCAL to LATEST, downloading from URL."
  (when (y-or-n-p
         (if local
             (format "%s %s is available (installed: %s). Update? "
                     name latest local)
           (format "%s %s is available. Install? " name latest)))
    (message "Downloading %s %s..." name latest)
    (url-retrieve url #'lsp-update--download-callback
                  (list name properties latest) t t)))

(defun lsp-update--download-callback (status name properties version)
  "Install NAME VERSION using PROPERTIES when STATUS indicates success."
  (let* ((target (lsp-update-executable name))
         (directory (file-name-directory target))
         temporary)
    (unwind-protect
        (if-let* ((failure (plist-get status :error)))
            (message "%s download failed: %s" name failure)
          (condition-case err
              (progn
                (lsp-update--response-body)
                (make-directory directory t)
                (setq temporary
                      (make-temp-file
                       (expand-file-name ".lsp-download-" directory)))
                (let ((coding-system-for-write 'binary))
                  (write-region (point) (point-max) temporary nil 'silent))
                (when (< (file-attribute-size (file-attributes temporary))
                         (or (plist-get properties :min-size) (* 1024 1024)))
                  (error "Downloaded file is unexpectedly small"))
                (set-file-modes temporary #o755)
                ;; The old server remains untouched until this atomic rename.
                (rename-file temporary target t)
                (setq temporary nil)
                (with-temp-file (lsp-update--version-file name)
                  (insert version "\n"))
                (message "%s updated to %s; restart its active LSP session"
                         name version))
            (error (message "%s installation failed: %s" name
                            (error-message-string err)))))
      (when (and temporary (file-exists-p temporary))
        (delete-file temporary))
      (kill-buffer (current-buffer)))))

(defun lsp-update--check (name properties)
  "Check NAME using PROPERTIES without blocking Emacs."
  (let ((repository (lsp-update--property properties :repository)))
    (url-retrieve
     (format "https://api.github.com/repos/%s/releases/latest" repository)
     #'lsp-update--check-callback (list name properties) t t)))

;;;###autoload
(defun lsp-update-check ()
  "Check all registered language servers for updates."
  (interactive)
  (dolist (server lsp-update-servers)
    (lsp-update--check (car server) (cdr server))))

(defun lsp-update-check-after-startup ()
  "Schedule one language-server update check after Emacs starts."
  (run-with-idle-timer lsp-update-startup-delay nil #'lsp-update-check))

(defun lsp-update--list-entries ()
  "Return rows describing the registered language servers."
  (mapcar
   (lambda (server)
     (let* ((name (car server))
            (properties (cdr server))
            (executable (lsp-update-executable name))
            (installed (file-executable-p executable)))
       (list name
             (vector (symbol-name name)
                     (or (lsp-update--local-version name properties) "—")
                     (if installed "● installed" "○ missing")
                     (abbreviate-file-name executable)))))
   lsp-update-servers))

(define-derived-mode lsp-update-list-mode tabulated-list-mode "Language Servers"
  "Display registered language servers and their installed versions."
  (setq tabulated-list-format
        [("Server" 18 t)
         ("Version" 14 t)
         ("Status" 14 t)
         ("Executable" 0 t)])
  (setq tabulated-list-padding 2
        tabulated-list-sort-key '("Server" . nil)
        tabulated-list-entries #'lsp-update--list-entries)
  (tabulated-list-init-header))

;;;###autoload
(defun lsp-update-list ()
  "Show registered language servers and their installed versions."
  (interactive)
  (let ((buffer (get-buffer-create "*Language Servers*")))
    (with-current-buffer buffer
      (lsp-update-list-mode)
      (tabulated-list-print t))
    (pop-to-buffer buffer)))

(add-hook 'after-init-hook #'lsp-update-check-after-startup)

(provide 'init-lsp-update)
;;; init-lsp-update.el ends here
