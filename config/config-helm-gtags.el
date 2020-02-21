(use-package helm-gtags
  :requires (ggtags)
  :init
  (progn
    (setq helm-gtags-ignore-case t
          helm-gtags-auto-update t
          helm-gtags-use-input-at-cursor t
          helm-gtags-pulse-at-cursor t)

    :config
    ;; Enable helm-gtags-mode in Dired so you can jump to any tag
    ;; when navigate project tree with Dired
    (add-hook 'dired-mode-hook 'helm-gtags-mode)

    ;; Enable helm-gtags-mode in Eshell for the same reason as above
    (add-hook 'eshell-mode-hook 'helm-gtags-mode)

    ;; Enable helm-gtags-mode in languages that GNU Global supports
    (add-hook 'c-mode-hook 'helm-gtags-mode)
    (add-hook 'c++-mode-hook 'helm-gtags-mode)
    (add-hook 'java-mode-hook 'helm-gtags-mode)
    (add-hook 'asm-mode-hook 'helm-gtags-mode)
    (add-hook 'python-mode 'helm-gtags-mode)
    (add-hook 'lisp-mode 'helm-gtags-mode)
    (add-hook 'elisp-mode 'helm-gtags-mode)


    ;; ;; ;; key bindings
    ;; :config
    ;; (with-eval-after-load 'helm-gtags
    ;;   (define-key helm-gtags-mode-map (kbd "M-t") 	'helm-gtags-find-tag)
    ;;   (define-key helm-gtags-mode-map (kbd "M-r") 	'helm-gtags-find-rtag)
    ;;   (define-key helm-gtags-mode-map (kbd "M-s s") 	'helm-gtags-find-symbol)
    ;;   (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
    ;;   (define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
    ;;   (define-key helm-gtags-mode-map (kbd "C-j") 	'helm-gtags-select)
    ;;   (define-key helm-gtags-mode-map (kbd "<C-M-return>") 'select-tags-table)
    ;;   (define-key helm-gtags-mode-map (kbd "M-.") 	'helm-gtags-dwim)
    ;;   (define-key helm-gtags-mode-map (kbd "C-c <") 	'helm-gtags-previous-history)
    ;;   (define-key helm-gtags-mode-map (kbd "C-c >") 	'helm-gtags-next-history)
    ;;   (define-key helm-gtags-mode-map (kbd "M-,") 	'helm-gtags-pop-stack)
    ;;   )
    ))

;;;;;;;;;;;;;;;;;;;;;;
;; (add-hook 'c-mode-common-hook
;;           (lambda () (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
;;                        (ggtags-mode 1)  )))

;; tags
;; (setq path-to-ctags "/usr/bin/cexuberant-ctags") ;; <- your ctags path here
;; (defun create-tags (dir-name)
;;   "Create tags file."
;;   (interactive "DDirectory: ")
;;   (shell-command
;;    (format "ctags -f %s -e -R %s" path-to-ctags (directory-file-name dir-name)))
;;   )


;; если вы хотите включить поддержку gnu global
;; (when (cedet-gnu-global-version-check t)
;;   (semanticdb-enable-gnu-global-databases 'c-mode)
;;   (semanticdb-enable-gnu-global-databases 'c++-mode))

;; включить поддержку ctags для основных языков:
;;  Unix Shell, Perl, Pascal, Tcl, Fortran, Asm
;; (when (cedet-ectag-version-check t)
;;   (semantic-load-enable-primary-exuberent-ctags-support))



;; (add-hook 'c-mode-common-hook
;;           (lambda ()
;;             (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
;;               (ggtags-mode 1))))

;; (define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
;; (define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
;; (define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
;; (define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
;; (define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
;; (define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)
;; (define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)


(provide 'config-helm-gtags)
