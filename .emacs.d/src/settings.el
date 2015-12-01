;;; settings.el --- Contains basic settings for my emacs
;;; Commentary:
;;; Contains the settings for tabspaces etc.

;;; Code:

; Stop startup message
(setq inhibit-startup-message 1)

(setq-default scroll-step 2)
(setq-default visible-bell 1)

(display-time)    ;; Show time in modeline
(column-number-mode 1) ;; Show column number in modeline

(setq-default kill-whole-line 1)
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

(electric-pair-mode 1)

(provide 'settings.el)
;;; settings.el ends here
