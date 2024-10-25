;;; init-elfeed.el --- Web feed reader for emacs  -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(maybe-require-package 'elfeed)

(global-set-key (kbd "C-x w") 'elfeed)

(setq elfeed-feeds
      '(("http://nullprogram.com/feed/" blog emacs)
        ("https://planet.emacslife.com/atom.xml" emacs)
	("https://sachachua.com/blog/feed/index.xml" blog emacs)
	("https://antfu.me/feed.xml" blog frontend)
	("https://yiming.dev/rss.xml" blog elixir)
	("https://www.piglei.com/feeds/latest/" blog python)
	("https://manateelazycat.github.io/feed.xml" blog emacs)
	("https://xenodium.com/rss.xml" blog emacs)))

(defun nerd-icon-for-tags (tags)
  "Generate Nerd Font icon based on tags.
  Returns default if no match."
  (cond ((member "youtube" tags)  (nerd-icons-faicon "nf-fa-youtube_play" :face '(:foreground "#FF0200")))
        ((member "instagram" tags) (nerd-icons-faicon "nf-fa-instagram" :face '(:foreground "#FF00B9")))
        ((member "emacs" tags) (nerd-icons-sucicon "nf-custom-emacs" :face '(:foreground "#9A5BBE")))
        ((member "github" tags) (nerd-icons-faicon "nf-fa-github"))
        (t (nerd-icons-faicon "nf-fae-feedly" :face '(:foreground "#2AB24C")))))

(defun lucius/elfeed-search-print-entry--better-default (entry)
  "Print ENTRY to the buffer."
  (let* ((date (elfeed-search-format-date (elfeed-entry-date entry)))
         (date-width (car (cdr elfeed-search-date-format)))
         (title (concat (or (elfeed-meta entry :title)
                            (elfeed-entry-title entry) "")
                        ;; NOTE: insert " " for overlay to swallow
                        " "))
         (title-faces (elfeed-search--faces (elfeed-entry-tags entry)))
         (feed (elfeed-entry-feed entry))
         (feed-title (when feed (or (elfeed-meta feed :title) (elfeed-feed-title feed))))
         (tags (mapcar #'symbol-name (elfeed-entry-tags entry)))
         (tags-str (mapconcat (lambda (s) (propertize s 'face 'elfeed-search-tag-face)) tags ","))
         (title-width (- (frame-width)
                         ;; (window-width (get-buffer-window (elfeed-search-buffer) t))
                         date-width elfeed-search-trailing-width))
         (title-column (elfeed-format-column
                        title (elfeed-clamp
                               elfeed-search-title-min-width
                               title-width
                               elfeed-search-title-max-width) :left))

         ​
         ;; Title/Feed ALIGNMENT
         (align-to-feed-pixel (+ date-width
                                 (max elfeed-search-title-min-width
                                      (min title-width elfeed-search-title-max-width)))))
    (insert (propertize date 'face 'elfeed-search-date-face) " ")
    (insert (propertize title-column 'face title-faces 'kbd-help title))
    (put-text-property (1- (point)) (point) 'display `(space :align-to ,align-to-feed-pixel))
    ;; (when feed-title (insert " " (propertize feed-title 'face 'elfeed-search-feed-face) " "))
    (when feed-title
      (insert " " (concat (nerd-icon-for-tags tags) " ")
              (propertize feed-title 'face 'elfeed-search-feed-face) " "))
    (when tags (insert "(" tags-str ")"))))

(setq  elfeed-search-print-entry-function #'lucius/elfeed-search-print-entry--better-default)

(provide 'init-elfeed)
;;; init-elfeed.el ends here
