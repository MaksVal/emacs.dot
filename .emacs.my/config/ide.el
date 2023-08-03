;; (require 'ede)
;;; use popup menu for yas-choose-value
(require 'popup)
(require 'cc-mode)
;;(require 'c-mode)
;;(require 'c++-mode)
(require 'semantic)
(require 'semantic/analyze)
(provide 'semantic-analyze)
(provide 'semantic-ctxt)
(provide 'semanticdb)
(provide 'semanticdb-find)
(provide 'semanticdb-mode)
(provide 'semantic-load)
;; (require 'ggtags)
;; !!
;;(require 'sr-speedbar)

;; My configs
;; (require 'ide-ecb)
(require 'ide-rust)

(use-package dash
  :ensure t
  :config
  (require  'dash)
)
;; (require 'yasnippet)

;; (require 'p4)

;;(require 'ac-helm)  ;; Not necessary if using ELPA package
;; (require 'company)

;; (show-paren-mode t) ;; enable show paren mode
;; (setq show-paren-style 'expression) ;; highlight whole expression
(use-package highlight-parentheses
   :ensure t
   :hook ((prog-mode . highlight-parentheses-mode))
   )

(use-package company
  :config
  (progn
    (add-hook 'after-init-hook 'global-company-mode)
    (global-set-key (kbd "M-/") 'company-complete-common-or-cycle)
    (setq company-idle-delay 0)))


(use-package flycheck
  :ensure t
  :config
  (progn
    (global-flycheck-mode)))

;; (setq stack-trace-on-error t)
(use-package irony
  :ensure t
  :disabled
  :config
  (progn
    ;; If irony server was never installed, install it.
    (unless (irony--find-server-executable) (call-interactively #'irony-install-server))

    (add-hook 'c++-mode-hook 'irony-mode)
    (add-hook 'c-mode-hook 'irony-mode)

    ;; Use compilation database first, clang_complete as fallback.
    (setq-default irony-cdb-compilation-databases '(irony-cdb-libclang
                                                    irony-cdb-clang-complete))

    (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
    ))

;; I use irony with company to get code completion.
;; (use-package company-irony
;;   :requires (company irony)
;;   :config
;;   (progn
;;     (eval-after-load 'company '(add-to-list 'company-backends 'company-irony))))

;; I use irony with flycheck to get real-time syntax checking.
(use-package flycheck-irony
  :ensure t
  :requires (flycheck irony)
  :config
  (progn
    (eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))))

;; Eldoc shows argument list of the function you are currently writing in the echo area.
(use-package irony-eldoc
	     :ensure t
  :requires (eldoc irony)
  :config
  (progn
    (add-hook 'irony-mode-hook #'irony-eldoc)))


(use-package rtags
  :disabled
  :config
  (progn
    (unless (rtags-executable-find "rc") (error "Binary rc is not installed!"))
    (unless (rtags-executable-find "rdm") (error "Binary rdm is not installed!"))

    (define-key c-mode-base-map (kbd "M-.")		'rtags-find-symbol-at-point)
    (define-key c-mode-base-map (kbd "M-,")		'rtags-find-references-at-point)
    (define-key c-mode-base-map (kbd "M-?")		'rtags-display-summary)
    (define-key c-mode-base-map (kbd "C-c <")	'rtags-location-stack-back)
    (define-key c-mode-base-map (kbd "C-c >")	'rtags-location-stack-forward)
    (rtags-enable-standard-keybindings)
    (setq rtags-completions-enabled t)
    (setq rtags-use-helm nil)

    ;; Shutdown rdm when leaving emacs.
    (add-hook 'kill-emacs-hook 'rtags-quit-rdm)
    )
  ;; TODO: Has no coloring! How can I get coloring?
  (use-package helm-rtags
    :disabled
    :requires (helm)
    :config
    (progn
      (setq rtags-display-result-backend 'helm)
      ))
  ;; Use rtags for auto-completion.
  (use-package company-rtags
	       :disabled
    :requires (company)
    :config
    (progn
      (setq rtags-autostart-diagnostics t)
      (rtags-diagnostics)
      (setq rtags-completions-enabled t)
      (push 'company-rtags company-backends)
      ))

  ;; Live code checking.
  (use-package flycheck-rtags
    :disabled
    :requires (flycheck)
    :config
    (progn
      ;; ensure that we use only rtags checking
      ;; https://github.com/Andersb
      (defun setup-flycheck-rtags ()
        (flycheck-select-checker 'rtags)
        (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
        (setq-local flycheck-check-syntax-automatically nil)
        (rtags-set-periodic-reparse-timeout 2.0)  ;; Run flycheck 2 seconds after being idle.
        )
      (add-hook 'c-mode-hook #'setup-flycheck-rtags)
      (add-hook 'c++-mode-hook #'setup-flycheck-rtags)
      ))
  )


;; (global-auto-complete-mode nil)
;; (setq ac-disable-faces nil)

;;;;;;;;;;;;;;;;;;;; Autocomplete ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Auto Complete
;; (require 'auto-complete)
;; (require 'auto-complete-config)
;; (require 'auto-complete-c-headers)
;; (require 'auto-complete-config)
;; (require 'auto-complete-clang)
;; (require 'auto-complete-clang-async
;;          "~/.emacs.d/extension/emacs-clang-complete-async/auto-complete-clang-async.el")

;; (defun ac-cc-mode-setup ()
;;   (setq ac-clang-complete-executable
;;         "~/.emacs.d/extension/emacs-clang-complete-async/clang-complete")
;;   (setq ac-sources '(ac-source-clang-async))
;;   (ac-clang-launch-completion-process)
;;   )

;; (add-hook 'after-init-hook 'global-company-mode)
;;;;;;;;;;;;;;;;;;;;;;;;; END ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;; Yasipnet ;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package yasnippet
	     :ensure t
	     :config
	     (yas-global-mode 1)
	     (defun yas-popup-isearch-prompt (prompt choices &optional display-fn)
	       (when (featurep 'popup)
		 (popup-menu*
		  (mapcar
		   (lambda (choice)
		     (popup-make-item
		      (or (and display-fn (funcall display-fn choice))
			  choice)
		      :value choice))
		   choices)
		  :prompt prompt
		  ;; start isearch mode immediately
		  :isearch t
		  )))
	     
	     (setq yas-prompt-functions '(yas-popup-isearch-prompt yas-ido-prompt yas-no-prompt))
	     )
;;;;;;;;;; END YAS ;;;;;;;;;;;



;;;; add some shotcuts in popup menu mode
;;(define-key ac-mode-map (kbd "M-TAB") 'auto-complete)

;; (define-key popup-menu-keymap (kbd "M-n") 'popup-next)
;; (define-key popup-menu-keymap (kbd "TAB") 'popup-next)
;; (define-key popup-menu-keymap (kbd "<tab>") 'popup-next)
;; (define-key popup-menu-keymap (kbd "<backtab>") 'popup-previous)
;; (define-key popup-menu-keymap (kbd "M-p") 'popup-previous)

;;  Enable line numbers on the left
;(global-linum-mode t)
(add-hook 'prog-mode-hook 'linum-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MODES
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist '("\\.h\\'" 		. c-mode))
(add-to-list 'auto-mode-alist '("\\.c\\'"  		. c-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" 	. c++-mode))
(add-to-list 'auto-mode-alist '("\\.cpp\\'" 	. c++-mode))
(add-to-list 'auto-mode-alist '("\\.cc\\'" 		. c++-mode))
(add-to-list 'auto-mode-alist '("\\.Single\\'"  . makefile-mode))
;;;;;;;;;;;;;;;; end modes ;;;;;;;;;;;;;;;;;;;;;;;;

;; (use-package go-mode
;;   :ensure t
;;   :config
;;   (add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode)))

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))


;;(setq lsp-keymap-prefix "C-c g")  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
(use-package lsp-mode
  :disabled
  :requires dash
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c g")
  :ensure t
  :defer t
  :hook ((c++-mode . lsp)
         (c-mode   . lsp)
         ;; (go-mode  . lsp)
         (lsp-mode . lsp-enable-which-key-integration)
         ;; (lsp-mode . (lambda ()
         ;;              (let ((lsp-keymap-prefix "C-c l"))
         ;;                (lsp-enable-which-key-integration)))
         ;;)
         )
  :commands (lsp lsp-deferred)
  :config
  '(lsp-project-blacklist (quote ("~/Projects/kernels/$")))
)




;; optionally
(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  ;; (define-key lsp-ui-mode-map (kbd "C-c g i") 'lsp-ui-imenu)
  (define-key lsp-ui-mode-map [remap xref-find-definitions] #'lsp-ui-peek-find-definitions)
  (define-key lsp-ui-mode-map [remap xref-find-references] #'lsp-ui-peek-find-references)
  )


;; if you are helm user
;;(use-package helm-lsp :commands helm-lsp-workspace-symbol)

;; if you are ivy user
(use-package lsp-ivy
  :commands lsp-ivy-workspace-symbol)
(use-package lsp-treemacs
  :commands lsp-treemacs-errors-list)

;; optionally if you want to use debugger
(use-package dap-mode
	     :ensure t)
;; (use-package dap-LANGUAGE) to load the dap adapter for your language

;; optional if you want which-key integration
(use-package which-key
	     :ensure t
  :config
  (which-key-mode))


;; C/C++
;; (use-package ccls
;;   :disabled
;;   :hook ((c-mode c++-mode objc-mode cuda-mode) .
;;          (lambda () (require 'ccls) (lsp)))
;;   :config
;;   (setq ccls-initialization-options '(:index (:comments 2) :completion (:detailedLabel t)))
;;   (require 'config-ccls)
;;   )

(use-package lsp-mode
  :commands lsp)
(use-package company-lsp
  :commands company-lsp)
(use-package company
	     :ensure t)
(use-package ccls
  :disabled
  :hook ((c-mode c++-mode objc-mode cuda-mode) .
         (lambda () (require 'ccls) (lsp))))


;; ;; Semantic + imenu
;; (defun my-semantic-hook ()
;;   (imenu-add-to-menubar "TAGS"))
;; (add-hook 'semantic-init-hooks 'my-semantic-hook)

;; (setq helm-semantic-fuzzy-match t
;;       helm-imenu-fuzzy-match    t)
;; (setq-local imenu-create-index-function #'ggtags-build-imenu-index)

;; (define-key c-mode-map   (kbd "<f6>") 'helm-semantic-or-imenu)
;; (define-key c++-mode-map (kbd "<f6>") 'helm-semantic-or-imenu)

;; (define-key c-mode-map (kbd "M-o")  'fa-show)
;; (define-key c++-mode-map (kbd "M-o")  'fa-show)

;; Go to this HEADER file
;; (global-set-key "\C-ci"  'semantic-decoration-include-visit)

;;;;;;;;;;;;;;;;;;;; Emacs plugins  ;;;;;;;;;;;;;;;;;;;;;
;; ECB

;;;;;;;;;;;;;;;;;;;;; CodeStyle ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package clang-format+
	     :ensure t
  :config
  (add-hook 'c-mode-common-hook #'clang-format+-mode)
  (add-hook 'c-mode-hook 'clang-format+-mode)
  (setq clang-format+-context #'modification)
  (local-set-key [tab] 'clang-format-region))



(setq c-default-style '((c-mode . "bsd")
                        (c++mode . "bsd")
                        (other . "free-group-style")))
;; TABs
(setq-default c-basic-offset 4
              tab-width 4
              indent-tabs-mode nil); отступ делается табами


;;;;;;;;;;;;;;;;;;;; Show TABs ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defvaralias 'c-basic-offset 'tab-width)
;; set this in all c-based programming modes
(add-hook 'c-mode-hook
          (lambda ()
            (c-set-offset 'case-label 4)))

;; whitespace http://www.emacswiki.org/emacs/WhiteSpace
(require 'whitespace)
(setq whitespace-style '(tabs tab-mark)) ;turns on white space mode only for tabs
;; (global-whitespace-mode t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)


;;;;;;;;;;;;;;;;;;;;; Navigation ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package ggtags
	     :ensure t
  :requires xref
  :config
  ;; Enable helm-gtags-mode in languages that GNU Global supports
  (add-hook 'c-mode-hook 'ggtags-mode 'xref-etags-mode)
  (add-hook 'c++-mode-hook 'ggtags-mode  'xref-etags-mode)
  (add-hook 'java-mode-hook 'ggtags-mode 'xref-etags-mode)
  (add-hook 'asm-mode-hook 'ggtags-mode 'xref-etags-mode)
  (add-hook 'python-mode 'ggtags-mode 'xref-etags-mode)
  (add-hook 'lisp-mode 'ggtags-mode 'xref-etags-mode)
  (add-hook 'elisp-mode 'ggtags-mode 'xref-etags-mode)
  )

;; (use-package helm-gtags
;;   :requires (ggtags)
;;   :bind ( :map helm-gtags-mode-map
;;                ("M-t" 			.  	'helm-gtags-find-tag)
;;                ("M-r" 			.  	'helm-gtags-find-rtag)
;;                ("C-c g g" 			.  	'helm-gtags-find-symbol)
;;                ;; ("M-g M-p" 		.  'helm-gtags-parse-file)
;;                ("C-c g f"		.  	'helm-gtags-tags-in-this-function)
;;                ("C-c g s"		.  	'helm-gtags-dwim)
;;                ("M-," 			.  	'helm-gtags-previous-history)
;;                ("M-." 			.  	'helm-gtags-next-history)
;;                )
;;   :init
;;   (progn
;;     (setq helm-gtags-ignore-case t
;;           helm-gtags-auto-update t
;;           helm-gtags-use-input-at-cursor t
;;           helm-gtags-pulse-at-cursor t)

;;     :config
;;     ;; Enable helm-gtags-mode in Dired so you can jump to any tag
;;     ;; when navigate project tree with Dired
;;     (add-hook 'dired-mode-hook 'helm-gtags-mode)

;;     ;; Enable helm-gtags-mode in Eshell for the same reason as above
;;     (add-hook 'eshell-mode-hook 'helm-gtags-mode)

;;     ;; Enable helm-gtags-mode in languages that GNU Global supports
;;     (add-hook 'c-mode-hook 'helm-gtags-mode)
;;     (add-hook 'c++-mode-hook 'helm-gtags-mode)
;;     (add-hook 'java-mode-hook 'helm-gtags-mode)
;;     (add-hook 'asm-mode-hook 'helm-gtags-mode)
;;     (add-hook 'python-mode 'helm-gtags-mode)
;;     (add-hook 'lisp-mode 'helm-gtags-mode)
;;     (add-hook 'elisp-mode 'helm-gtags-mode)

;;     ;; ;; ;; key bindings
;;     ;; :config
;;     ;; (with-eval-after-load 'helm-gtags
;;     ;;   (define-key helm-gtags-mode-map (kbd "M-t") 	'helm-gtags-find-tag)
;;     ;;   (define-key helm-gtags-mode-map (kbd "M-r") 	'helm-gtags-find-rtag)
;;     ;;   (define-key helm-gtags-mode-map (kbd "M-s s") 	'helm-gtags-find-symbol)
;;     ;;   (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
;;     ;;   (define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
;;     ;;   (define-key helm-gtags-mode-map (kbd "C-j") 	'helm-gtags-select)
;;     ;;   (define-key helm-gtags-mode-map (kbd "<C-M-return>") 'select-tags-table)
;;     ;;   (define-key helm-gtags-mode-map (kbd "M-.") 	'helm-gtags-dwim)
;;     ;;   (define-key helm-gtags-mode-map (kbd "C-c <") 	'helm-gtags-previous-history)
;;     ;;   (define-key helm-gtags-mode-map (kbd "C-c >") 	'helm-gtags-next-history)
;;     ;;   (define-key helm-gtags-mode-map (kbd "M-,") 	'helm-gtags-pop-stack)
;;     ;;   )
;;     ))

;;;;;;;;;;;;;;;;;;;; Navigation KERNEL ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package helm-cscope
  :disabled
  :bind ( :map helm-cscope-mode-map
               ("C-c s s" . helm-cscope-find-this-symbol)
               ("C-c s =" . helm-cscope-find-assignments-to-this-symbol)
               ("C-c s d" . helm-cscope-find-global-definition)
               ("C-c s c" . helm-cscope-find-called-function-no-promt)
               ("C-c s C" . helm-cscope-find-calling-this-funtcion-no-promt)
               ("C-c s ." . helm-cscope-pop-mark))
  :config
  (add-hook 'c-mode-common-hook 'helm-cscope-mode)
  (add-hook 'c++-mode-common-hook 'helm-cscope-mode)

  ;; (define-key helm-cscope-mode-map (kbd "C-c s s") 'helm-cscope-find-symbol)
  ;; 	(define-key helm-cscope-mode-map (kbd "C-c s =") 'helm-cscope-find-assignments-to-this-symbol)
  ;;    (define-key helm-cscope-mode-map (kbd "C-c s d") 'helm-cscope-find-global-definition)
  ;;    (define-key helm-cscope-mode-map (kbd "C-c s c") 'helm-cscope-find-called-function)
  ;;    (define-key helm-cscope-mode-map (kbd "C-c s C") 'helm-cscope-find-calling-this-funtcion)
  ;;    (define-key helm-cscope-mode-map (kbd "C-c s .") 'helm-cscope-select))
  )

;; END KERNEL

;;;;;;;;;;;;;;;;;;;; MARKDOWN format ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))


;;;;;;;;;;;;;;;;;;;; P4 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package p4
	     :ensure t
  :config
  (global-set-key (kbd "C-c p") 'p4-prefix-map)
  (global-set-key (kbd "C-x p") 'p4-status)
  )
;;;;;;;;;;;;;;;;;;;; Magit ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package magit
	     :ensure t
  :config
  ;; For Magit: disable auto revert buffer
  (setq magit-auto-revert-mode nil)
  (setq magit-gpg-secret-key-hist nil)    ; For working gpg-agent
  (global-set-key (kbd "C-c g") 'magit-file-dispatch)
  ;; Magit status
  (global-set-key (kbd "C-x g") 'magit-status)

)


(provide 'ide)
