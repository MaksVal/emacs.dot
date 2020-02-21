(setq-default
 custom-enabled-themes (quote (spacemacs-dark))
 custom-safe-themes
   (quote ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default))) 

(if (daemonp)
    (add-hook 'after-make-frame-functions
              (lambda (frame)
                (with-selected-frame frame (load-theme 'spacemacs-dark t))))
  (load-theme 'spacemacs-dark t))

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

(use-package powerline
  :config
  (powerline-default-theme)
  )

(use-package smart-mode-line-powerline-theme
  :ensure t
  :after powerline
  :after smart-mode-line
  :config
  (add-to-list 'sml/replacer-regexp-list (quote ("^~/Dropbox/" ":DBox:")) t)
  (add-to-list 'sml/replacer-regexp-list '("^~/Dropbox/" ":DBox:"))
  (add-to-list 'sml/replacer-regexp-list '("^~/Git-Projects/" ":Git:") t)
  (add-to-list 'sml/replacer-regexp-list '("^:Git:\(.*\)/src/main/java/" ":G/\1/SMJ:") t)
  (add-to-list 'sml/replacer-regexp-list '("^~/ORG" ":Org:") t)
  (add-to-list 'sml/replacer-regexp-list '("^~/\\.emacs\\.d/elpa/" ":ELPA:") t)
  (add-to-list 'sml/replacer-regexp-list '("^~/\\.emacs\\.d/" ":ED:") t)
  (add-to-list 'sml/replacer-regexp-list '("^/sudo:.*:" ":SU:") t)
  (add-to-list 'sml/replacer-regexp-list '("^~/Documents/" ":Doc:") t)
  (add-to-list 'sml/replacer-regexp-list '("^:\\([^:]*\\):Documento?s/" ":\\1/Doc:") t)
  (add-to-list 'sml/replacer-regexp-list '("^~/[Gg]it[Hh]ub/" ":Git:") t)
  (add-to-list 'sml/replacer-regexp-list '("^~/[Gg]it/" ":Git:") t)
  (add-to-list 'sml/replacer-regexp-list '("^~/[Gg]it\\([Hh]ub\\|\\)-?[Pp]rojects/" ":Git:") t)
  (add-to-list 'sml/replacer-regexp-list '("~/Projects/\\(\\w+\\s_*\\w*\\)/*"
                                           (lambda (s) (concat ":" (upcase (match-string 1 s)) ":")))
               t)
  (add-to-list 'sml/replacer-regexp-list '("~/sources/\\(\\w+\\s_*\\w*\\)/*"
                                           (lambda (s) (concat ":" (upcase (match-string 1 s)) ":")))
               t)
  (setq sml/shorten-directory t)
  (setq sml/shorten-modes t)
  (setq sml/show-file-name t)
  (setq sml/no-confirm-load-theme t)
  ;; (setq sml/theme 'smart-mode-line-powerline)

  (sml/setup)
  (sml/apply-theme 'powerline)
  )


(provide 'config-faces)
