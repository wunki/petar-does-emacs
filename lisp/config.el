;;; config.el --- Emacs tweaks, not dependant on packages -*- lexical-binding: t -*-

;;; Code:

(require 'lib)

;; Buffer encoding
(prefer-coding-system       'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-language-environment   'utf-8)

;; No startup screen
(setq inhibit-startup-screen t)

;; No startup message
(setq inhibit-startup-message t)
(setq inhibit-startup-echo-area-message t)

;; No message in scratch buffer
(setq initial-scratch-message nil)

;; Initial buffer
(setq initial-buffer-choice nil)

;; No frame title
(setq frame-title-format nil)

;; No file dialog
(setq use-file-dialog nil)

;; No dialog box
(setq use-dialog-box nil)

;; No popup windows
(setq pop-up-windows nil)

;; No empty line indicators
(setq indicate-empty-lines nil)

;; Text mode is initial mode
(setq initial-major-mode 'text-mode)

;; Text mode is default major mode
(setq default-major-mode 'text-mode)

;; No cursor in inactive windows
(setq cursor-in-non-selected-windows nil)

;; Moderate font lock
(setq font-lock-maximum-decoration nil)

;; No limit on font lock
(setq font-lock-maximum-size nil)

;; No line break space points
(setq auto-fill-mode nil)

;; Fill column at 80
(setq fill-column 80)

;; No confirmation for visiting non-existent files
(setq confirm-nonexistent-file-or-buffer nil)

;; Completion style, see
;; gnu.org/software/emacs/manual/html_node/emacs/Completion-Styles.html
(setq completion-styles '(basic substring))

;; Just follow symlinks
(setq vc-follow-symlinks t)

;; Ask for y/n instead of 'yes' or 'no'
(defalias 'yes-or-no-p 'y-or-n-p)   

;; Use aspell for spell checking
(setq ispell-program-name "aspell")

;; No load noises please
(setq ring-bell-function 'ignore)

;; Let lines wrap
(global-visual-line-mode 1)

;; Update the buffer when a file changes
(global-auto-revert-mode 1)

;; Delete a marked region
(delete-selection-mode 1)

;; Use shift + direction to switch between windows
(windmove-default-keybindings)

;; Stop emacs from adding configuration to my setup
(setq custom-file (make-temp-file "emacs-custom"))

;; Setup indentation
(set-default 'indent-tabs-mode nil)
(setq-default tab-width 4)

;; Size of temporary buffers
(temp-buffer-resize-mode)
(setq temp-buffer-max-height 8)

;; Minimum window height
(setq window-min-height 1)

;; Emacs writes backup files to `filename~` by default. This is messy,
;; so let's tell it to write them to `~/.emacs.d/backup` instead.
;; If you have an accident, check this directory - you might get lucky.
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
    backup-by-copying t    ; Don't delink hardlinks
    version-control t      ; Use version numbers on backups
    delete-old-versions t  ; Automatically delete excess backups
    kept-new-versions 20   ; how many of the newest versions to keep
    kept-old-versions 5    ; and how many of the old
    )

;; If available, use `xdg-open' to open URLs.
(when (is-exec "xdg-open")
  (setq-default
   browse-url-browser-function (quote browse-url-generic)
   browse-url-generic-program "xdg-open"))

(provide 'config)
;;; config.el ends here
