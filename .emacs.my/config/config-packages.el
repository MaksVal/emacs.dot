(use-package el-get
  :ensure t
)

(require 'el-get)
(add-to-list 'el-get-recipe-path "~/sources/emacs/el-get/recipes")
(setq el-get-verbose t)

;; where to find init-package.el files
(setq el-get-user-package-directory "~/emacs.my/packages.d")

;; personal recipes
(setq el-get-sources
      '((:name el-get :branch "master")

	(:name expand-region
	       :before (global-set-key (kbd "C-@") 'er/expand-region))

	(:name deft
	       :before (progn
                         (setq deft-default-extension "md")
                         (setq deft-directory "~/dev/emacs.d/notes")))

	(:name anything
	       :features anything-config
	       :before (global-set-key (kbd "M-s a") 'dim:anything-occur)
	       :after  (setq w3m-command nil))

	(:name descbinds-anything
	       :after (progn
			(descbinds-anything-install)
			(global-set-key (kbd "C-h b") 'descbinds-anything)))

	(:name vkill
	       :checksum fbaf37ba613a661eb46e3e380d72be8da0277cd0)

	(:name goto-last-change
	       :before (global-set-key (kbd "C-x C-/") 'goto-last-change))

	(:name popwin
	       :load-path ("." "misc")
	       :before (setq display-buffer-function 'popwin:display-buffer))

	(:name adoc-mode
	       :before (setq adoc-insert-replacement nil))

	;; (:name hide-region
	;;        :features hide-region
	;;        :before (progn
	;; 		 (global-set-key (kbd "C-c h h") 'hide-region-hide)
	;; 		 (global-set-key (kbd "C-c h r") 'hide-region-hide)
	;; 		 (global-set-key (kbd "C-c h u") 'hide-region-unhide)))

	;; (:name pgdevenv-el
	;;        :before (setq pgdev-ccache-path "/usr/local/bin/ccache"))

	;; (:name main-line
	;;        :before (setq main-line-separator-style 'arrow))

        (:name json-mode
               :features json-mode
               :after (define-key json-mode-map (kbd "M-q") 'json-mode-beautify))

	(:name switch-window
	       :before (progn
			 (global-set-key (kbd "C-x o") 'switch-window)
			 (global-set-key (kbd "C-x 9") 'delete-other-window)))

	(:name cssh
	       :after (cssh-define-global-bindings))))

;; my packages
(setq my-packages
      (append
       ;; list of packages we use straight from official recipes
       '(maggit
	 spacemacs-theme dired-sidebar all-the-icons-dired powerline
	 smart-mode-line-powerline-theme doom-themes doom-modeline gitlab helm-gitlab
	 helm-config helm-swoop counsel ivy markdown-mode org-jira dash highlight-parentheses
	 company flycheck irony company-irony flycheck-irony irony-eldoc rtags helm-rtags company-rtags
	 flycheck-rtags yasnippet flycheck lsp-mode lsp-ui helm-lsp lsp-ivy lsp-treemacs dap-mode which-key
	 ccls lsp-mode company-lsp company ccls clang-format+ ggtags helm-gtags helm-cscope markdown-mode
	 p4 magit projectile  helm-projectile ede rustic lsp-mode lsp-ui tfsmacs org plantuml-mode org-mime
	 flyspell org-mru-clock
	 )

       (mapcar 'el-get-as-symbol (mapcar 'el-get-source-name el-get-sources))))
       
      

;; for notify, apt-get install libnotify-bin
;; (loop for p in '(emms notify)		; verbiste?
;;       do (add-to-list 'list-packages p))

(el-get 'sync my-packages)

(provide 'config-packages)
