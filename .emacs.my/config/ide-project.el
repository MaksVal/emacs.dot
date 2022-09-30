(require 'ede)
(require 'projectile)

(require 'helm-projectile)

(use-package projectile
  :init
  (when (file-directory-p "~/Projects/")
    (setq projectile-project-search-path '("~/Projects/")))
  (setq projectile-switch-project-action #'projectile-dired)
  :diminish projectile-mode
  :hook ((prog-mode . projectile-mode))
  :bind ( :map projectile-mode-map ("C-c C-p" . projectile-command-map))
  :config (projectile-mode)
  (setq projectile-completion-system 'ivy
        ;; projectile-indexing-method 'git
        projectile-enable-caching t
        projectile-indexing-method 'native
        )
  (setq projectile-project-compilation-cmd "")
  ;; (helm-projectile-on)
)

(provide 'ide-project)
