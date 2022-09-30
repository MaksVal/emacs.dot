;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(setq url-proxy-services
   '(("no_proxy" . "^\\(localhost\\|10\\..*\\|192\\.168\\..*\\)")
     ("http" . "192.168.137.1:3128")
     ("https" . "192.168.137.1:3128")))


(setq custom-file "~/.emacs.my/init.el")



(require 'cl-lib)

(setq inhibit-startup-message t)
;; (add-to-list 'load-path    ".emacs.my/" )
(add-to-list 'load-path    "~/.emacs.my/config/")

;; (add-to-list 'load-path    "~/.emacs.my/external/")
;; (add-to-list 'load-path    "~/.emacs.my/external/")
;; (add-to-list 'load-path    "~/.emacs.my/gsync/" )
;; (add-to-list 'load-path    "~/.emacs.my/custom/")

(require 'repoconf)

;; cask
(require 'cask "~/.cask/cask.el")
;; (require 'cask "/usr/share/cask/cask.el")
(cask-initialize)
(package-initialize t)
(debug-on-entry 'package-initialize)


(require 'dbus)

(setq use-package-always-demand (daemonp))

;;;;;;;;;;;;;;;;;;;
;; My config
;;;;;;;;;;;;;;;;;;;
(require 'optimization)
;; (eval-when-compile
;;   ;; Following line is not needed if use-package.el is in ~/.emacs.my
;;   (require 'use-package))
(require 'config-base)
(require 'config-faces)
(require 'variablesconf)
(require 'keybindsconf)
;;(require 'popup)
(require 'config-ivy)
(require 'ide)
(require 'ide-project)
;; (require 'config-helm-gtags)
(require 'config-console)
(require 'ui)
;;;;;;;;;;;;;;;;;;;

(server-start)

(require 'epa-file)
(epa-file-enable)
;; (setq epg-gpg-program "/usr/bin/gpg")
(setq epa-pinentry-mode 'loopback)

(when (memq window-system '(x))
  (exec-path-from-shell-initialize))

(require 'orgconf)
(require 'plantuml-mode)
;;(require 'orgsync)

(require 'config-markdown)
;;(require 'w3m-conf)
;; (if (file-exists-p "~/.mail")
;;     (require 'mail))
;;;;; Account settings
(if (file-exists-p "~/.emacs.my/config/mail-acc.el")
  (require 'mail-acc)
  )
;;;;;;;;;;;;;;;;;;;;;;



(require 'unicode-fonts)
(unicode-fonts-setup)
;; log4e
(add-to-list 'load-path    "~/.emacs.my/extension/log4e")
(require 'log4e)

;; Проверка орфографии
(add-to-list 'load-path    "~/.emacs.my/extension/chkspell")
(require 'chkspell)

(if (file-exists-p "~/.emacs.my/config/config-gitlab.el")
   (require 'config-gitlab))

(if (file-exists-p "~/.emacs.my/config/config-youtrack.el")
    (require 'config-youtrack))

(require 'config-org-jira)


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
;; (add-to-list 'load-path		"~/.emacs.my/extension/youtrack")
;; (require 'youtrack)

;; FileManager config
;; (require 'fm)

;;;; Pls, install before use
;; (require 'config-sauron)
;;;; WebKit: need by python-environment
;; (add-to-list 'load-path    "~/.emacs.my/extension/webkit")
;; (require 'webkit)

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
 '(blink-cursor-mode nil)
 '(org-confirm-babel-evaluate nil)
 '(org-export-with-sub-superscripts nil)
 '(package-selected-packages
   (quote
    (wrap-region which-key wcheck-mode visual-fill-column virtualenvwrapper use-package unicode-fonts twittering-mode tfsmacs tangotango-theme tango-plus-theme tango-2-theme sr-speedbar spacemacs-theme smart-mode-line-powerline-theme slime simpleclip sauron ranger prodigy pbcopy paredit paganini-theme ox-gfm org-sync org-redmine org-noter org-mru-clock org-mobile-sync org-mime nyan-mode nav nasm-mode multi-term mu4e-maildirs-extension mu4e-alert move-text magit lua-mode lsp-ui lsp-ivy json-rpc ivy-rtags irony-eldoc html-to-markdown highlight-parentheses helm-themes helm-swoop helm-rtags helm-projectile helm-mu helm-lsp helm-ls-git helm-gtags helm-gitlab helm-flyspell helm-flymake helm-flycheck helm-emms helm-descbinds helm-cscope helm-company helm-c-yasnippet gitlab-ci-mode-flycheck git-timemachine ggtags fuzzy flycheck-rtags flycheck-irony expand-region exec-path-from-shell excorporate evil es-windows es-lib epc elfeed el-get ecb doom-themes doom-modeline dired-sidebar dap-mode counsel-projectile company-shell company-rtags company-irony company-c-headers color-theme cmake-mode cil-mode cider ccls bbdb auto-complete-clang auto-complete-c-headers anaconda-mode all-the-icons-dired airline-themes ac-helm)))
 '(show-paren-mode t)
 '(tool-bar-mode nil))


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

'(comint-highlight-prompt ((t nil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
