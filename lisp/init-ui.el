;; set frame size
(when window-system (set-frame-size (selected-frame) 150 60))

;; set the font size and family
(defun my-favorite-font-set ()
    (set-frame-font "Iosevka 12" nil t))

(my-run-with-idle-timer 1 (lambda ()
                            (my-favorite-font-set)))  

(provide 'init-ui)