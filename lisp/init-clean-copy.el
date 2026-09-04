;;; init-clean-copy.el --- Copy code without debug output -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require 'replace)

(defgroup clean-copy nil
  "Copy code without debug-output lines."
  :group 'tools)

(defcustom clean-copy-debug-output-regexps
  '(((python-mode python-ts-mode)
     . ("^[[:blank:]]*\\(?:print\\|pprint\\(?:\\.pprint\\)?\\)[[:blank:]]*("))
    ((js-mode js-ts-mode typescript-ts-mode tsx-ts-mode)
     . ("^[[:blank:]]*console\\."))
    ((go-mode go-ts-mode)
     . ("^[[:blank:]]*\\(?:fmt\\.Print\\|print\\(?:ln\\)?[[:blank:]]*(\\)"))
    ((csharp-mode csharp-ts-mode)
     . ("^[[:blank:]]*\\(?:System\\.\\)?Console\\.Write"))
    ((elixir-mode elixir-ts-mode)
     . ("^[[:blank:]]*\\(?:IO\\.\\(?:puts\\|inspect\\|write\\)\\|dbg\\)[[:blank:]]*("))
    ((erlang-mode erlang-ts-mode)
     . ("^[[:blank:]]*io:\\(?:format\\|fwrite\\)[[:blank:]]*("))
    ((haskell-mode)
     . ("^[[:blank:]]*\\(?:print\\|putStr\\(?:Ln\\)?\\)[[:blank:]]")))
  "Debug-output line regexps grouped by applicable major modes.

Each regexp is passed to `flush-lines', so a matching line is removed
from the copied text.  Add another (MODES . REGEXPS) entry to support a
new language."
  :type '(alist :key-type (repeat symbol) :value-type (repeat regexp))
  :group 'clean-copy)

(defcustom clean-copy-extra-debug-output-regexps nil
  "Additional debug-output regexps applied in every language.

This may also supply all rules for a major mode absent from
`clean-copy-debug-output-regexps'."
  :type '(repeat regexp)
  :group 'clean-copy)

(defun clean-copy--debug-output-regexps ()
  "Return debug-output regexps applicable to the current buffer."
  (let (result)
    (dolist (entry clean-copy-debug-output-regexps)
      (when (apply #'derived-mode-p (car entry))
        (setq result (append result (cdr entry)))))
    (append result clean-copy-extra-debug-output-regexps)))

(defun clean-copy--without-debug-output (text regexps)
  "Return TEXT without lines matching any of REGEXPS."
  (with-temp-buffer
    (insert text)
    (dolist (regexp regexps)
      (flush-lines regexp (point-min) (point-max)))
    (buffer-string)))

;;;###autoload
(defun copy-region-without-debug-output (beg end)
  "Copy the active region from BEG to END without debug-output lines.

The original buffer is not modified.  The result is placed in the kill
ring and, when clipboard integration is active, the system pasteboard."
  (interactive
   (if (use-region-p)
       (list (region-beginning) (region-end))
     (user-error "Select the code to copy first")))
  (let ((regexps (clean-copy--debug-output-regexps)))
    (unless regexps
      (user-error
       "No debug-output regexps configured for %s" major-mode))
    (kill-new
     (clean-copy--without-debug-output
      (buffer-substring-no-properties beg end)
      regexps))
    (setq deactivate-mark t)
    (message "Copied region without debug output")))

(global-set-key (kbd "C-c w") #'copy-region-without-debug-output)

(provide 'init-clean-copy)
;;; init-clean-copy.el ends here
