;;; early-init.el --- the earliest inits -*- lexical-binding: t -*-
;;
;;; Commentary:
;;
;; On M1 macs, the GCC libraries need to be added to the so
;; we can make use of native compilation.
;;
;;; Code:
;;
(eval-when-compile (require 'subr-x))

(when (file-directory-p "/opt/homebrew")
  (setenv
    "LIBRARY_PATH"
    (string-join
      '
      ("/opt/homebrew/opt/gcc/lib/gcc/11"
        "/opt/homebrew/opt/libgccjit/lib/gcc/11"
        "/opt/homebrew/opt/gcc/lib/gcc/11/gcc/aarch64-apple-darwin21/11")
      ":")))

(provide 'early-init)
;;; early-init.el ends here
