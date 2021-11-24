;;; navigation.el --- enhancements to make it easier to navigate emacs -*- lexical-binding: t -*-

;;; Code:

;; Generic completion framework for the minibuffer
(use-package ivy
  :config
  (ivy-mode t)
  (setq ivy-initial-inputs-alist nil))

;; Ivy enhanced versions of emacs commands
(use-package counsel
  :bind (("M-x" . counsel-M-x)))

;; Sorts and filters candidates for Ivy
(use-package prescient)
(use-package ivy-prescient
  :requires prescient
  :config
  (ivy-prescient-mode t))

;; Enhanced version of isearch
(use-package swiper
  :bind (("M-s" . counsel-grep-or-swiper)))

;; Presents menus for ivy commands
(use-package ivy-hydra)

;; Suggests the next key, depending on the pressed key
(use-package which-key
  :config
  (add-hook 'after-init-hook 'which-key-mode))

(provide 'navigation)
;;; navigation.el ends here