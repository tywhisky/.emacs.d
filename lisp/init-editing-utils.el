;;; init-editing-utils.el --- Day-to-day editing helpers -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(require-package 'unfill)
(require 'ffap)

(when (fboundp 'electric-pair-mode)
  (add-hook 'after-init-hook 'electric-pair-mode))


;;; Some basic preferences

(setq-default
 blink-cursor-interval 0.4
 bookmark-default-file (locate-user-emacs-file ".bookmarks.el")
 buffers-menu-max-size 30
 case-fold-search t
 column-number-mode t
 ediff-split-window-function 'split-window-horizontally
 ediff-window-setup-function 'ediff-setup-windows-plain
 indent-tabs-mode nil
 mouse-yank-at-point t
 save-interprogram-paste-before-kill t
 scroll-preserve-screen-position 'always
 set-mark-command-repeat-pop t
 tooltip-delay 1.5
 truncate-lines nil
 truncate-partial-width-windows nil)

(let ((backup-dir (locate-user-emacs-file "var/backups/"))
      (auto-save-dir (locate-user-emacs-file "var/auto-save/")))
  (make-directory backup-dir t)
  (make-directory auto-save-dir t)
  (setq backup-directory-alist `(("." . ,backup-dir))
        auto-save-file-name-transforms `((".*" ,auto-save-dir t))))

(setq mode-line-collapse-minor-modes t)

(add-hook 'text-mode-hook 'visual-line-mode)

(add-hook 'after-init-hook 'delete-selection-mode)

(add-hook 'after-init-hook 'global-auto-revert-mode)
(setq global-auto-revert-non-file-buffers t
      auto-revert-verbose nil)

(add-hook 'after-init-hook 'transient-mark-mode)


;; Huge files

(when (fboundp 'so-long-enable)
  (add-hook 'after-init-hook 'so-long-enable))

(require-package 'vlf)

(defun ffap-vlf ()
  "Find file at point with VLF."
  (interactive)
  (let ((file (ffap-file-at-point)))
    (unless (file-exists-p file)
      (error "File does not exist: %s" file))
    (vlf file)))


;; Keep boundary errors quiet; their messages still appear in the echo area.
(setq ring-bell-function #'ignore)



;;; Newline behaviour (see also electric-indent-mode, enabled above)

(defun sanityinc/newline-at-end-of-line ()
  "Move to end of line, enter a newline, and reindent."
  (interactive)
  (move-end-of-line 1)
  (newline-and-indent))

(global-set-key (kbd "S-<return>") 'sanityinc/newline-at-end-of-line)


(global-set-key (kbd "S-<backspace>") 'kill-whole-line)

(defun tywhisky/backward-delete-word (arg)
  "Delete ARG words backward without saving them to the kill ring."
  (interactive "p")
  (let ((end (point)))
    (backward-word arg)
    (delete-region (point) end)))

(global-set-key (kbd "C-<backspace>") 'tywhisky/backward-delete-word)



(global-display-fill-column-indicator-mode 1)
(setq-default display-line-numbers-width 3)



(when (require-package 'rainbow-delimiters)
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))


(when (maybe-require-package 'symbol-overlay)
  (dolist (hook '(prog-mode-hook html-mode-hook yaml-ts-mode-hook conf-mode-hook))
    (add-hook hook 'symbol-overlay-mode))
  (with-eval-after-load 'symbol-overlay
    (define-key symbol-overlay-mode-map (kbd "M-i") 'symbol-overlay-put)
    (define-key symbol-overlay-mode-map (kbd "M-I") 'symbol-overlay-remove-all)
    (define-key symbol-overlay-mode-map (kbd "M-n") 'symbol-overlay-jump-next)
    (define-key symbol-overlay-mode-map (kbd "M-p") 'symbol-overlay-jump-prev)))


;;; Zap *up* to char is a handy pair for zap-to-char
(global-set-key (kbd "M-Z") 'zap-up-to-char)


;; Don't disable narrowing commands
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-defun 'disabled nil)
;; Don't disable case-change functions
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Show matching parens
(add-hook 'after-init-hook
          (lambda ()
            (show-paren-mode)
            (custom-set-faces
             '(show-paren-match ((t (:weight bold)))))
              (setq show-paren-when-point-inside-paren t
                    show-paren-when-point-in-periphery t
                    show-paren-context-when-offscreen t
                    show-paren-delay 0.2)))

(when (fboundp 'repeat-mode)
  (add-hook 'after-init-hook 'repeat-mode))


;;; Handy key bindings

(with-eval-after-load 'help
  (define-key help-map "A" 'describe-face))

(global-set-key (kbd "C-.") 'set-mark-command)
(global-set-key (kbd "C-x C-.") 'pop-global-mark)

(when (maybe-require-package 'avy)
  (global-set-key (kbd "C-;") 'avy-goto-char-timer))

(require-package 'multiple-cursors)
;; multiple-cursors
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-+") 'mc/mark-next-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Train myself to use M-f and M-b instead
(global-unset-key [M-left])
(global-unset-key [M-right])

(defun kill-back-to-indentation ()
  "Kill from point back to the first non-whitespace character on the line."
  (interactive)
  (let ((prev-pos (point)))
    (back-to-indentation)
    (kill-region (point) prev-pos)))

(global-set-key (kbd "C-M-<backspace>") 'kill-back-to-indentation)



;;; Page break lines

(when (maybe-require-package 'page-break-lines)
  (add-hook 'after-init-hook 'global-page-break-lines-mode))



;; Shift lines up and down with M-up and M-down. When paredit is enabled,
;; it will use those keybindings. For this reason, you might prefer to
;; use M-S-up and M-S-down, which will work even in lisp modes.

(require-package 'move-dup)
(global-set-key [M-S-up] 'move-dup-move-lines-up)
(global-set-key [M-S-down] 'move-dup-move-lines-down)

(global-set-key (kbd "C-c d") 'move-dup-duplicate-down)
(global-set-key (kbd "C-c u") 'move-dup-duplicate-up)


;;; Fix backward-up-list to understand quotes, see http://bit.ly/h7mdIL

(defun sanityinc/backward-up-sexp (arg)
  "Jump up to the start of the ARG'th enclosing sexp."
  (interactive "p")
  (let ((ppss (syntax-ppss)))
    (cond ((elt ppss 3)
           (goto-char (elt ppss 8))
           (sanityinc/backward-up-sexp (1- arg)))
          ((backward-up-list arg)))))

(global-set-key [remap backward-up-list] 'sanityinc/backward-up-sexp) ; C-M-u, C-M-up



;;; Cut/copy the current line if no region is active
(require-package 'whole-line-or-region)
(add-hook 'after-init-hook 'whole-line-or-region-global-mode)



;; M-^ is inconvenient, so also bind M-j
(global-set-key (kbd "M-j") 'join-line)


;; Random line sorting
(defun sanityinc/sort-lines-random (beg end)
  "Sort lines in region from BEG to END randomly."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (let ;; To make `end-of-line' and etc. to ignore fields.
          ((inhibit-field-text-motion t))
        (sort-subr nil 'forward-line 'end-of-line nil nil
                   (lambda (_s1 _s2) (eq (random 2) 0)))))))


(add-hook 'after-init-hook 'which-key-mode)
(setq-default which-key-idle-delay 1.5)


(defun sanityinc/disable-features-during-macro-call (orig &rest args)
  "When running a macro, disable features that might be expensive.
ORIG is the advised function, which is called with its ARGS."
  (let (post-command-hook
        font-lock-mode
        (tab-always-indent (or (eq 'complete tab-always-indent) tab-always-indent)))
    (apply orig args)))

(advice-add 'kmacro-call-macro :around 'sanityinc/disable-features-during-macro-call)


(auto-save-visited-mode 1)


(provide 'init-editing-utils)
;;; init-editing-utils.el ends here
