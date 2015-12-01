;;; .emacs --- Main config file for my emacs
;;; Commentary:
;;; This loads 2 files in ~/.emacs.d folder which handle my packages related configurations.
;;; This itself contains base emacs specific configurations.

;;; Code:
(require 'package)
(package-initialize)

 ;; To stop the startup message
(setq inhibit-startup-message t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "667e296942c561382fe0a8584c26be0fe7a80416270c3beede8c6d69f2f77ccc" "04d735f8b10046cbfc7a002f199cac24e3db78b2d19a5f6c8ea182493f3c0655" default)))
 '(send-mail-function nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Set up theme
(setq custom-safe-themes t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
					;(load-theme 'spacemacs-dark t)
(load-theme 'wombat t)

(setq-default scroll-step 2)
(setq-default visible-bell t)

(display-time)
(column-number-mode t)
(setq-default kill-whole-line t)

(global-set-key [home] 'beginning-of-line)
(global-set-key [end] 'end-of-line)
(global-set-key [(control home)] 'beginning-of-buffer)
(global-set-key [(control end)] 'end-of-buffer)
(define-key esc-map [right] 'kill-word)         ;; esc -> kill-word
(define-key esc-map [left] 'backward-kill-word) ;; esc <- backward-kill-word

;; Setup Alt Keys
(global-set-key [(alt b)] `buffer-menu)
(global-set-key [(alt c)] `copy-region-as-kill)        ; ESC-w
(global-set-key [(alt g)] `goto-line)

(load "~/.emacs.d/my-loadpackages.el")
;(add-hook 'after-init-hook '(lambda ()
  ;(load "~/.emacs.d/my-noexternals.el")
;))

;; view docs and scroll the page while in another buffer
(fset 'doc-prev "\C-xo\C-x[\C-xo")
(fset 'doc-next "\C-xo\C-x]\C-xo")
(global-set-key (kbd "M-[") 'doc-prev)
(global-set-key (kbd "M-]") 'doc-next)

;; Continous scrolling in doc view
(require 'doc-view)
(setq doc-view-continuous t)

;; Zooming in doc view with control+mouse
(global-set-key [C-mouse-4] 'text-scale-increase)
(global-set-key [C-wheel-up] 'text-scale-decrease)

;; Saving emacs history
(require 'savehist)
(savehist-mode 1)
(setq savehist-additional-variables '(kill-ring search-ring regexp-search-ring))
(setq savehist-file "~/.emacs.d/savehist")

;; Some packages I like to load whenever they get time
(load-file "~/.emacs.d/on-screen.el")
(load-file "~/.emacs.d/sudo-save.el")

;; Shortcuts to allow using mouse in emacs
(require 'mouse)
(xterm-mouse-mode t)

(electric-pair-mode 1)
(setq tab-width 2)

; Indent using spaces instead of tabso
(setq-default indent-tabs-mode nil)

(linum-mode 1)

;; Resize windows
(global-set-key (kbd "C-x <up>") 'shrink-window)
(global-set-key (kbd "C-x <down>") 'enlarge-window)
(global-set-key (kbd "C-x <left>") 'shrink-window-horizontally)
(global-set-key (kbd "C-x <right>") 'enlarge-window-horizontally)

(defun open-line-above (N)
    "Insert a new line above the current point position.
With arg N, insert N newlines."
    (interactive "p")
    (save-excursion
      (beginning-of-line)
      (newline N)))

;; Open newlines above current position
(global-set-key (kbd "C-S-o") 'open-line-above)

(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b")))
  (blink-cursor-mode -1)
  (tool-bar-mode -1))

;; Ditch scrollbars
(scroll-bar-mode -1)

;; Other-window is M-o
(global-set-key "\M-o" 'other-window)

(add-to-list 'exec-path "~/.cabal/bin/")

(provide '.emacs)
;;; .emacs ends here
