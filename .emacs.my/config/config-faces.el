(add-hook 'shell-mode-hook
      (lambda ()
        (face-remap-set-base 'comint-highlight-prompt :inherit nil)))

(add-hook 'shell-dirtrack-mode-hook
      (lambda ()
        (face-remap-set-base 'comint-highlight-prompt :inherit nil)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Compilation mode
;;; ANSI Coloring in Compilation Mode
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)

(use-package spacemacs-theme
  :defer t
  :init
  (load-theme 'spacemacs-dark t)
  (setq spacemacs-theme-org-agenda-height nil)
  (setq spacemacs-theme-org-height nil)
  (setq-default
   custom-enabled-themes (quote (spacemacs-dark))
   custom-safe-themes
   (quote ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
  (if (daemonp)
      (add-hook 'after-make-frame-functions
		(lambda (frame)
		  (with-selected-frame frame (load-theme 'spacemacs-dark t))))
    (load-theme 'spacemacs-dark t))
  )

(use-package dired-sidebar
  :bind (("C-x C-n" . dired-sidebar-toggle-sidebar))
  :ensure t
  :commands (dired-sidebar-toggle-sidebar)
  :config
  (setq dired-sidebar-subtree-line-prefix " .")
  (cond
   ((eq system-type 'darwin)
    (if (display-graphic-p)
        (setq dired-sidebar-theme 'icons)
      (setq dired-sidebar-theme 'nerd))
    (setq dired-sidebar-face '(:family "Hack Regular" :height 140)))
   ((eq system-type 'windows-nt)
    (setq dired-sidebar-theme 'nerd)
    (setq dired-sidebar-face '(:family "Droid Sans Mono" :height 110)))
   (:default
    (setq dired-sidebar-theme 'nerd)
    (setq dired-sidebar-face '(:family "Arial" :height 140))))

  (setq dired-sidebar-use-term-integration t)
  (setq dired-sidebar-use-custom-font t)

  (use-package all-the-icons-dired
    ;; M-x all-the-icons-install-fonts
    :ensure t
    :commands (all-the-icons-dired-mode)))

;; (use-package powerline
;;   :config
;;   (powerline-default-theme)
;;   )



;; (use-package smart-mode-line-powerline-theme
;;   :ensure t
;;   :after powerline
;;   :after smart-mode-line
;;   :config
;;   (add-to-list 'sml/replacer-regexp-list (quote ("^~/Dropbox/" ":DBox:")) t)
;;   (add-to-list 'sml/replacer-regexp-list '("^~/Dropbox/" ":DBox:"))
;;   (add-to-list 'sml/replacer-regexp-list '("^~/Git-Projects/" ":Git:") t)
;;   (add-to-list 'sml/replacer-regexp-list '("^:Git:\(.*\)/src/main/java/" ":G/\1/SMJ:") t)
;;   (add-to-list 'sml/replacer-regexp-list '("^~/ORG" ":Org:") t)
;;   (add-to-list 'sml/replacer-regexp-list '("^~/\\.emacs\\.d/elpa/" ":ELPA:") t)
;;   (add-to-list 'sml/replacer-regexp-list '("^~/\\.emacs\\.d/" ":ED:") t)
;;   (add-to-list 'sml/replacer-regexp-list '("^/sudo:.*:" ":SU:") t)
;;   (add-to-list 'sml/replacer-regexp-list '("^~/Documents/" ":Doc:") t)
;;   (add-to-list 'sml/replacer-regexp-list '("^:\\([^:]*\\):Documento?s/" ":\\1/Doc:") t)
;;   (add-to-list 'sml/replacer-regexp-list '("^~/[Gg]it[Hh]ub/" ":Git:") t)
;;   (add-to-list 'sml/replacer-regexp-list '("^~/[Gg]it/" ":Git:") t)
;;   (add-to-list 'sml/replacer-regexp-list '("^~/[Gg]it\\([Hh]ub\\|\\)-?[Pp]rojects/" ":Git:") t)
;;   (add-to-list 'sml/replacer-regexp-list '("~/Projects/\\(\\w+\\s_*\\w*\\)/*"
;;                                            (lambda (s) (concat ":" (upcase (match-string 1 s)) ":")))
;;                t)
;;   (add-to-list 'sml/replacer-regexp-list '("~/sources/\\(\\w+\\s_*\\w*\\)/*"
;;                                            (lambda (s) (concat ":" (upcase (match-string 1 s)) ":")))
;;                t)
;;   (setq sml/shorten-directory t)
;;   (setq sml/shorten-modes t)
;;   (setq sml/show-file-name t)
;;   (setq sml/no-confirm-load-theme t)
;;   ;; (setq sml/theme 'smart-mode-line-powerline)

;;   (sml/setup)
;;   (sml/apply-theme 'powerline)
;;   )


(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-material t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package doom-modeline
  :after (:all doom-themes)
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  ;; Determines the style used by `doom-modeline-buffer-file-name'.
  ;;
  ;; Given ~/Projects/FOSS/emacs/lisp/comint.el
  ;;   auto => emacs/lisp/comint.el (in a project) or comint.el
  ;;   truncate-upto-project => ~/P/F/emacs/lisp/comint.el
  ;;   truncate-from-project => ~/Projects/FOSS/emacs/l/comint.el
  ;;   truncate-with-project => emacs/l/comint.el
  ;;   truncate-except-project => ~/P/F/emacs/l/comint.el
  ;;   truncate-upto-root => ~/P/F/e/lisp/comint.el
  ;;   truncate-all => ~/P/F/e/l/comint.el
  ;;   truncate-nil => ~/Projects/FOSS/emacs/lisp/comint.el
  ;;   relative-from-project => emacs/lisp/comint.el
  ;;   relative-to-project => lisp/comint.el
  ;;   file-name => comint.el
  ;;   buffer-name => comint.el<2> (uniquify buffer name)
  ;;
  ;; If you are experiencing the laggy issue, especially while editing remote files
  ;; with tramp, please try `file-name' style.
  ;; Please refer to https://github.com/bbatsov/projectile/issues/657.
  (setq doom-modeline-buffer-file-name-style 'auto)
  ;; Whether display the `lsp' state. Non-nil to display in the mode-line.
  (setq doom-modeline-lsp t)
  ;; How to detect the project root.
  ;; The default priority of detection is `ffip' > `projectile' > `project'.
  ;; nil means to use `default-directory'.
  ;; The project management packages have some issues on detecting project root.
  ;; e.g. `projectile' doesn't handle symlink folders well, while `project' is unable
  ;; to hanle sub-projects.
  ;; You can specify one if you encounter the issue.
  (setq doom-modeline-project-detection 'project)
  )

;; Or use this
;; Use `window-setup-hook' if the right segment is displayed incorrectly
;; (use-package doom-modeline
;;   :ensure t
;;   :hook (after-init . doom-modeline-mode))

(provide 'config-faces)
