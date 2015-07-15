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

;; Highlighting over-limit code.
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

;; ws-butler. Delete trailing whitespaces.
(unless (package-installed-p 'ws-butler)
  (package-refresh-contents) (package-install 'ws-butler))
(require 'ws-butler)
(ws-butler-global-mode)
(add-hook 'prog-mode-hook 'ws-butler-mode)

;; Projectile
(unless (package-installed-p 'projectile)
  (package-refresh-contents) (package-install 'projectile))
(unless (package-installed-p 'helm-projectile)
  (package-refresh-contents) (package-install 'helm-projectile))
(require 'projectile)
(require 'helm-projectile)
(projectile-global-mode)
(setq projectile-enable-caching t)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(global-set-key (kbd "C-f") 'projectile-find-file)

;; Robe. Ruby programming.
(unless (package-installed-p 'robe)
  (package-refresh-contents) (package-install 'robe))

;; Two space tab for Java mode.
(add-hook 'java-mode-hook (lambda ()
			    (setq c-basic-offset 2
				  tab-width 2
				  indent-tabs-mode t)))

;; Goto line.
(global-set-key "\C-xg" `goto-line)

;; helm projectile ag
(unless (package-installed-p 'helm-ag)
  (package-refresh-contents) (package-install 'helm-ag))
(require 'helm-ag)
(global-set-key "\M-s" `helm-projectile-ag)

;; auto-complete
(unless (package-installed-p 'auto-complete)
  (package-refresh-contents) (package-install 'auto-complete))
(ac-config-default)

;; Configure emacs to cut and copy text to Mac OS X clipboard
(unless (package-installed-p 'pbcopy)
  (package-refresh-contents) (package-install 'pbcopy))
(require 'pbcopy)
(turn-on-pbcopy)

;; For screen key mapping.
(define-key input-decode-map "\e[1;2D" [S-left])
(define-key input-decode-map "\e[1;2C" [S-right])
(define-key input-decode-map "\e[1;2B" [S-down])
(define-key input-decode-map "\e[1;2A" [S-up])
(define-key input-decode-map "\e[1;2F" [S-end])
(define-key input-decode-map "\e[1;2H" [S-home])

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
            `((".*" ,temporary-file-directory t)))
