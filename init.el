;; This allow us to put downloaded .el file into customization directory.
(add-to-list 'load-path "~/.emacs.d/lisp")

;;(cua-mode 1)
(transient-mark-mode 1)
(setq shift-select-mode t)

;; line number mode
(setq line-number-mode t)
(setq column-number-mode t)

;; Scala and thrift support
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(unless (package-installed-p 'scala-mode2)
  (package-refresh-contents) (package-install 'scala-mode2))
(unless (package-installed-p 'thrift)
  (package-refresh-contents) (package-install 'thrift))
(unless (package-installed-p 'thrift)
  (package-refresh-contents) (package-install 'ws-butler))

(require 'whitespace)
(setq whitespace-line-column 100) ;; limit line length
(setq whitespace-style '(face lines-tail))

(add-hook 'prog-mode-hook 'whitespace-mode)
(global-whitespace-mode +1)

;; Mouse scroll
;; mouse integration
(require 'mouse) ;; needed for iterm2 compatibility
(xterm-mouse-mode t)
(global-set-key [mouse-4] '(lambda ()
			     (interactive)
			     (scroll-down 1)))
(global-set-key [mouse-5] '(lambda ()
			     (interactive)
			     (scroll-up 1)))
(setq mouse-sel-mode t)
(defun track-mouse (e))
