;;; init-utils.el --- Elisp helper functions and commands -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Handier way to add modes to auto-mode-alist
(defun add-auto-mode (mode &rest patterns)
  "Add entries to `auto-mode-alist' to use `MODE' for all given file `PATTERNS'."
  (dolist (pattern patterns)
    (add-to-list 'auto-mode-alist (cons pattern mode))))

;; Like diminish, but for major modes
(defun sanityinc/set-major-mode-name (name)
  "Override the major mode NAME in this buffer."
  (setq-local mode-name name))

(defun sanityinc/major-mode-lighter (mode name)
  (add-hook (derived-mode-hook-name mode)
            (apply-partially 'sanityinc/set-major-mode-name name)))

(defmacro sanityinc/fullframe-mode (mode)
  "Configure buffers that open in MODE to display in full-frame."
  `(add-to-list 'display-buffer-alist
                (cons (cons 'major-mode ,mode)
                      (list 'sanityinc/display-buffer-full-frame))))

;; Open my `init.el`
(defun tywhisky/open-init-file ()
  "Open the init file."
  (interactive)
  (find-file user-init-file))

(when (string= system-type "darwin")       
  (setq dired-use-ls-dired nil))

(global-set-key (kbd "C-c i") 'tywhisky/open-init-file)


(defun my/colorize-compilation-buffer ()
  "Interpret ANSI color codes in compilation buffers."
  (ansi-color-apply-on-region compilation-filter-start (point)))

(add-hook 'compilation-filter-hook 'my/colorize-compilation-buffer)

(defun tywhisky/project-root ()
  "Find the project root by looking for mix.exs or package.json."
  (or (locate-dominating-file default-directory "mix.exs")
      (locate-dominating-file default-directory "package.json")
      (user-error "Not in a mix or npm project")))

(defun tywhisky/read-package-json-scripts (root)
  "Read scripts from package.json in ROOT."
  (let* ((pkg-file (expand-file-name "package.json" root))
         (json-object-type 'hash-table)
         (json-key-type 'string)
         (json-array-type 'list)
         (data (json-read-file pkg-file)))
    (gethash "scripts" data)))

(defun tywhisky/read-mix-tasks (root)
  "Read mix tasks from mix.exs in ROOT (very rough parse)."
  (let* ((file (expand-file-name "mix.exs" root))
         (content (with-temp-buffer
                    (insert-file-contents file)
                    (buffer-string)))
         (aliases '()))
    (when (string-match "defp aliases do[[:space:]]*%{" content)
      (save-match-data
        (with-temp-buffer
          (insert content)
          (goto-char (point-min))
          (while (re-search-forward "\"\\([^\"]+\\)\"" nil t)
            (push (match-string 1) aliases)))))
    (nreverse aliases)))

(defun tywhisky/run-project-script ()
  "List project scripts from mix.exs or package.json and run one."
  (interactive)
  (let* ((root (tywhisky/project-root))
         (scripts (cond
                   ((file-exists-p (expand-file-name "package.json" root))
                    (tywhisky/read-package-json-scripts root))
                   ((file-exists-p (expand-file-name "mix.exs" root))
                    (tywhisky/read-mix-tasks root))))
         (choices (if (hash-table-p scripts)
                      (hash-table-keys scripts)
                    scripts))
         (cmd (completing-read "Run script: " choices)))
    (cond
     ;; npm/yarn/pnpm
     ((hash-table-p scripts)
      (compile (format "npm run %s" cmd)))
     ;; mix alias
     (t
      (compile (format "mix %s" cmd))))))

(provide 'init-utils)
;;; init-utils.el ends here
