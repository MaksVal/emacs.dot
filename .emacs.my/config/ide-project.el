(use-package projectile
  :ensure t
  :hook ((prog-mode . projectile-mode))
  :bind ( :map projectile-mode-map ("C-c C-p" . projectile-command-map))
  :config
  (require 'projectile)
  (setq projectile-completion-system 'ivy
        ;; projectile-indexing-method 'git
        projectile-enable-caching t
        projectile-indexing-method 'native
        )
  (setq projectile-project-compilation-cmd "")
  ;; (helm-projectile-on)

  )

(use-package helm-projectile
   :ensure t
   :disabled)

(use-package ede
  :config
  (require 'ede)
)


(provide 'ide-project)
