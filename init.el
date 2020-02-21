;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(setq custom-file "~/.emacs.d/init.el")

(package-initialize)

(setq inhibit-startup-message t)
;; (add-to-list 'load-path    ".emacs.d/" )
(add-to-list 'load-path    "~/.emacs.d/config/")

;; (add-to-list 'load-path    "~/.emacs.d/external/")
;; (add-to-list 'load-path    "~/.emacs.d/external/")
;; (add-to-list 'load-path    "~/.emacs.d/gsync/" )
;; (add-to-list 'load-path    "~/.emacs.d/custom/")

(require 'repoconf)

;; cask
(require 'cask "~/.cask/cask.el")
(cask-initialize)

(require 'dbus)

;;;;;;;;;;;;;;;;;;;
;; My config
;;;;;;;;;;;;;;;;;;;
(require 'config-faces)
(require 'variablesconf)
(require 'keybindsconf)
;;(require 'popup)
(require 'config-helm)
(require 'ide)
(require 'ide-project)
;; (require 'config-helm-gtags)
(require 'config-console)
(require 'ui)
;;;;;;;;;;;;;;;;;;;


(require 'epa-file)
(epa-file-enable)
;; (setq epg-gpg-program "/usr/bin/gpg")
(setq epa-pinentry-mode 'loopback)

(when (memq window-system '(x))
  (exec-path-from-shell-initialize))

(require 'orgconf)
;;(require 'orgsync)

(require 'config-markdown)
;;(require 'w3m-conf)
;; (if (file-exists-p "~/.mail")
;;     (require 'mail))
;;;;; Account settings
(if (file-exists-p "~/.emacs.d/config/mail-acc.el")
  (require 'mail-acc)
  )
;;;;;;;;;;;;;;;;;;;;;;



(require 'unicode-fonts)
(unicode-fonts-setup)
;; log4e
(add-to-list 'load-path    "~/.emacs.d/extension/log4e")
(require 'log4e)

;; Проверка орфографии
(add-to-list 'load-path    "~/.emacs.d/extension/chkspell")
(require 'chkspell)

(if (file-exists-p "~/.emacs.d/config/config-gitlab.el")
   (require 'config-gitlab))

(if (file-exists-p "~/.emacs.d/config/config-youtrack.el")
    (require 'config-youtrack))


;; Helm Descbinds
;;;;;;;
; Helm Descbinds provides an interface to emacs’ describe-bindings
; making the currently active key bindings interactively searchable
; with helm.
;;;;;;;
(require 'helm-descbinds)
(helm-descbinds-mode)

;;;;;;;;


;; helm-emms
;;;;;;;;
; Basic helm interface to emms
;;;;;;;;
;; (require 'config-emms)

;; YouTrack
;; (add-to-list 'load-path		"~/.emacs.d/extension/youtrack")
;; (require 'youtrack)

;; FileManager config
;; (require 'fm)

;;;; Pls, install before use
;; (require 'config-sauron)
;;;; WebKit: need by python-environment
;; (add-to-list 'load-path    "~/.emacs.d/extension/webkit")
;; (require 'webkit)

;;;;;;;;;;;
;; For Magit: disable auto revert buffer
(setq magit-auto-revert-mode nil)
(setq magit-gpg-secret-key-hist nil)    ; For working gpg-agent

;(require 'tango-2-theme)
;(require 'tango-plus-theme)
;(require 'tangotango-theme)
;(require 'paganini-theme)

;(require 'airline-themes)

;; (if (fboundp 'gnutls-available-p)
;;     (fmakunbound 'gnutls-available-p))
;; (setq tls-program '("gnutls-cli --tofu -p %p %h")
;;       imap-ssl-program '("gnutls-cli --tofu -p %p %s")
;;       smtpmail-stream-type 'starttls
;;       starttls-extra-arguments '("--tofu")
;;       )


;;;; Smooth Scroll Step == 1 ;;;;
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed 't) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;;;; Current line is highlighted ;;;;
(global-hl-line-mode 1)
;;;;;

;;; Auto Save ;;;
;; Save all tempfiles in $TMPDIR/emacs$UID/
(defconst emacs-tmp-dir (format "%s/%s%s/" temporary-file-directory "emacs" (user-uid)))
(setq backup-directory-alist 			`((".*" . ,emacs-tmp-dir)))
(setq auto-save-file-name-transforms	`((".*" ,emacs-tmp-dir t)))
(setq auto-save-list-file-prefix 		emacs-tmp-dir)
;; nyan
;; (nyan-mode t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (package-build shut-up epl git commander f dash s))))


;; (custom-set-faces
;; custom-set-faces was added by Custom.
;; If you edit it by hand, you could mess it up, so be careful.
;; Your init file should contain only one such instance.
;; If there is more than one, they won't work right.
;; '(default ((t (:family "Hack" :foundry "bitstream" :slant normal :weight normal :height 120 :width normal)))))

;; Set default font
;; (set-face-attribute 'default nil
;;                     :family "Hack"
;;                     :height 110
;;                     :weight 'normal
;;                     :width 'normal)

;;;;; Set font ;;;;;
;; Please, add this line to ~/.Xresources
;; Emacs.FontBackend: 		xft
;; Emacs.font:				Hack-12
;;;;;
;; And run:
;; xrdb -merge ~/.Xresources
;;;;;;;;;;;;;;;;;;;;

;; (ido-mode t)


;; ;; move text left/right
;; (defun my-indent-region (N)
;;   (interactive "p")
;;   (if (use-region-p)
;;       (progn (indent-rigidly (region-beginning) (region-end) (* N 2))
;;              (setq deactivate-mark nil))
;;     (self-insert-command N)))

;; (defun my-unindent-region (N)
;;   (interactive "p")
;;   (if (use-region-p)
;;       (progn (indent-rigidly (region-beginning) (region-end) (* N -2))
;;              (setq deactivate-mark nil))
;;     (self-insert-command N)))

;; (global-set-key [s-right] 'my-indent-region)
;; (global-set-key [s-left] 'my-unindent-region)

;; clojure
;; (add-hook 'cider-mode-hook #'eldoc-mode)
;; (add-hook 'cider-mode-hook #'paredit-mode)
;; (add-hook 'cider-mode-hook #'highlight-parentheses-mode)
;; (add-hook 'cider-mode-hook #'imenu-add-menubar-index)

;; aliases
(defalias 'yes-or-no-p 'y-or-n-p)
(defalias 'rs 'replace-string)
(defalias 'sl 'sort-lines)
(defalias 'rr 'reverse-region)
(defalias 'rg 'rgrep)
(defalias 'dir 'dired)
(defalias 'fnd 'find-name-dired)
(defalias 'df 'diff-mode)
(defalias 'mt 'multi-term)
(defalias 'rb 'rename-buffer)
(defalias 'rev 'revert-buffer)
(defalias 'him 'helm-imenu)
(defalias 'hl 'highlight-phrase)
(defalias 'hlr 'highlight-regexp)
(defalias 'uhl 'unhighlight-regexp)
(defalias 'oc 'occur)
(defalias 'ms 'magit-status)
(defalias 'blame 'magit-blame)

;; common
(show-paren-mode 1)
;; (setq show-paren-style 'parenthesis)
;; (setq show-paren-style 'expression)
(setq confirm-kill-emacs 'y-or-n-p)
(blink-cursor-mode 0)
(tool-bar-mode -1)
(setq auto-save-default nil)
(setq make-backup-files nil)

(progn
  (setq default-buffer-file-coding-system 'utf-8)
  (setq-default coding-system-for-read    'utf-8)
  (setq file-name-coding-system           'utf-8)
  (set-selection-coding-system            'utf-8)
  (set-keyboard-coding-system        'utf-8-unix)
  (set-terminal-coding-system             'utf-8)
  (prefer-coding-system                   'utf-8))

(setq system-uses-terminfo nil)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
(setq multi-term-program "/bin/bash")
(global-set-key (kbd "s-d") 'delete-backward-char)
(put 'downcase-region 'disabled nil)
(menu-bar-mode 0)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
