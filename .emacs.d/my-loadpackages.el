;;; my-loadpackages --- configuration for packages
;;; Commentary:
; loaded after packages have been installed

;;; Code:
(load "~/.emacs.d/my-packages.el")

(require 'magit)
(define-key global-map (kbd "C-c m") 'magit-status)

(require 'powerline)
(powerline-default-theme)

(require 'markdown-mode)

;(require 'ido)
;(ido-mode t)

;;============================================================
(require 'helm)
(require 'helm-config)
(require 'helm-net)
(require 'helm-files)
(require 'helm-command)
(helm-mode 1)

;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-unset-key (kbd "C-x c"))

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z

(when (executable-find "curl")
  (setq helm-net-prefer-curl))

(helm-autoresize-mode t)
(global-set-key (kbd "M-x") 'helm-M-x)
(setq helm-M-x-fuzzy-match t) ;; optional fuzzy matching for helm-M-x
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

; keep a list of recently opened files
(recentf-mode 1)
(setq-default recent-save-file "~/.emacs.d/recentf")

(global-set-key (kbd "C-x C-f") 'helm-find-files)

(setq helm-split-window-in-side-p           t ; open helm buffer inside current window, not occupy whole other window
      helm-move-to-line-cycle-in-source     t ; move to end or beginning of source when reaching top or bottom of source.
      helm-ff-file-name-history-use-recentf t ; should show recent files at the top
      helm-scroll-amount                    8); scroll 8 lines other window using M-<next>/M-<prior>
;;      helm-ff-search-library-in-sexp        t ; search for library in `require' and `declare-function' sexp.

(define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to do persistent action
(define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
(define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z


;;============================================================


(require 'tabbar)
(tabbar-mode 1)

(require 'haskell-mode)
(require 'haskell-interactive-mode)
(require 'haskell-process)
(add-hook 'haskell-mode-hook 'interactive-haskell-mode)

(custom-set-variables
  '(haskell-process-suggest-remove-import-lines t)
  '(haskell-process-auto-import-loaded-modules t)
  '(haskell-process-log t)
	'(haskell-tags-on-save))

(require 'speedbar)
(speedbar-add-supported-extension ".hs")

(define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
(define-key haskell-mode-map (kbd "C-`") 'haskell-interactive-bring)
(define-key haskell-mode-map (kbd "C-c C-t") 'haskell-process-do-type)
(define-key haskell-mode-map (kbd "C-c C-i") 'haskell-process-do-info)
(define-key haskell-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
(define-key haskell-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
(define-key haskell-mode-map (kbd "C-c c") 'haskell-process-cabal)
(define-key haskell-mode-map (kbd "SPC") 'haskell-mode-contextual-space)
(define-key haskell-mode-map (kbd "C-x C-s") 'haskell-mode-save-buffer)

;; To jump to the location of the top-level identifier at point, run
(define-key haskell-mode-map (kbd "M-.") 'haskell-mode-jump-to-def-or-tag)

(require 'yasnippet)

(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20151112.2030/dict/")
(ac-config-default)

(add-to-list 'load-path "which-folder-ace-jump-mode-file-in/")
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(require 'multi-term)
(setq multi-term-program "/bin/zsh")
(add-hook 'term-mode-hook
          (lambda ()
            (setq term-buffer-maximum-size 10000)))
(add-hook 'term-mode-hook
          (lambda ()
            (define-key term-raw-map (kbd "C-y") 'term-paste)))

(autoload 'ghc-init "ghc" nil t)
(autoload 'ghc-debug "ghc" nil t)
(add-hook 'haskell-mode-hook (lambda () (ghc-init)))

;; dart mode
(require 'flycheck)
(require 'dart-mode)
(setq dart-executable-path "/opt/dart-sdk/bin/dart")
(setq dart-analysis-server-snapshot-path "/opt/dart-sdk/bin/snapshots/analysis_server.dart.snapshot")
(setq dart-debug t)
(setq dart-enable-analysis-server t)
(add-to-list 'auto-mode-alist '("\\.dart\\'" . dart-mode))
(add-hook 'dart-mode-hook 'dart-file-handle)
(add-hook 'dart-mode-hook 'flycheck-mode)(setq dart-enable-analysis-server t)
(add-hook 'dart-mode-hook 'flycheck-mode)

;; js2-mode
;; Requires jshint for flychecking
(require 'js2-mode)
(flycheck-mode t)
(setq js-indent-level 2)
(add-hook 'js2-mode-hook 'flycheck-mode)

(provide 'my-loadpackages.el)
;;; my-loadpackages.el ends here
