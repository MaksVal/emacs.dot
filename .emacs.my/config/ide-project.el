(require 'ede)
(require 'projectile)

(require 'helm-projectile)

(use-package projectile
  :hook ((prog-mode . projectile-mode))
  :bind ( :map projectile-mode-map ("C-c C-p" . projectile-command-map))
  :config
  (setq projectile-completion-system 'ivy
        ;; projectile-indexing-method 'git
        projectile-enable-caching t
        )
  (setq projectile-project-compilation-cmd "")
  ;; (helm-projectile-on)

  )


(provide 'ide-project)
