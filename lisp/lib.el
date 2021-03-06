;;; lib.el --- my utulity functions -*- lexical-binding: t -*-
;;
;;; Commentary:
;;
;; Add helpful functions to our Emacs.  All functions should start
;; with `pet' so we can easily find them.
;; 
;;; Code:
;;

(require 'packages)

(use-package s
  :commands (s-trim s-concat))

(defun pet/kill-region-or-backward-word ()
  "Kill either the word backwards or the active region."
  (interactive)
  (if (region-active-p)
    (kill-region (region-beginning) (region-end))
    (backward-kill-word 1)))

(defun pet/find-config ()
  "Edit my configuration file."
  (interactive)
  (find-file "~/.config/emacs/init.el"))

(defun pet/reload-config ()
  "Reloads all Emacs configuration."
  (interactive)
  (load-file user-init-file))

(defun pet/is-mac ()
  "Return non-nil if running on a mac."
  (interactive)
  (eq system-type 'darwin))

(defun pet/is-wsl ()
  "Return non-nil if running on Windows WSL."
  (interactive)
  (and (string-equal system-type 'gnu/linux) (getenv "WSLENV")))

(defun pet/is-linux ()
  "Return non-nil if running on Linux."
  (interactive)
  (and (not (pet/is-wsl)) (string-equal system-type "gnu/linux")))

(defun pet/delete-file-and-buffer ()
  "Kill the current buffer and deletes the file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (when filename
      (if (vc-backend filename)
        (vc-delete-file filename)
        (progn
          (delete-file filename)
          (message "Deleted file %s" filename)
          (kill-buffer))))))

(defun pet/rename-file-and-buffer ()
  "Rename the current buffer and file it is visiting."
  (interactive)
  (let ((filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer is not visiting a file!")
      (let ((new-name (read-file-name "New name: " filename)))
        (cond
         ((vc-backend filename) (vc-rename-file filename new-name))
         (t
          (rename-file filename new-name t)
          (set-visited-file-name new-name t t)))))))

(defun pet/eshell-here ()
  "Opens up a new shell in the directory associated with the current buffer's file.
The eshell is renamed to match that directory to make multiple eshell
windows easier."
  (interactive)
  (let*
    (
      (parent
        (if (buffer-file-name)
          (file-name-directory (buffer-file-name))
          default-directory))
      (height (/ (window-total-height) 3))
      (name (car (last (split-string parent "/" t)))))
    (split-window-vertically (- height))
    (other-window 1)
    (eshell "new")
    (rename-buffer (concat "*eshell: " name "*"))))

(defun pet/url-get-title (url &optional)
  "Takes a URL and returns the value of the <title> HTML tag."
  (let ((buffer (url-retrieve-synchronously url))
        (title nil))
    (save-excursion
      (set-buffer buffer)
      (goto-char (point-min))
      (search-forward-regexp "<title>\\([^<]+?\\)</title>")	
      (setq title (match-string 1 ) )
      (kill-buffer (current-buffer)))
    title))
(setq org-make-link-description-function 'pet/url-get-title)

(defun eshell/q ()
  (insert "exit")
  (eshell-send-input)
  (delete-window))

(defun pet/set-font (font)
  "Take a FONT and set it.
If the window-system is active, it directly changes the font.
Otherwise it adds it to the so it works with the Emacs daemon."
  (interactive "sFont: ")
  (if (window-system)
      (set-frame-font font)
    (add-to-list 'default-frame-alist `(font . ,font))))

(provide 'lib)
;;; lib.el ends here
