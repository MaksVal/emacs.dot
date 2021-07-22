;;(require 'helm-config)
;; (require 'helm)
;; (require 'helm-descbinds)
;; (require 'helm-ls-git)
;; (helm-descbinds-mode)

(use-package helm-config
  :disabled
  :demand t
  :init
  (setq helm-move-to-line-cycle-in-source t
        helm-ff-file-name-history-use-recentf t
        helm-ff-newfile-prompt-p 	nil
        helm-ff-skip-boring-files t
        helm-ff-ido-style-backspace 'always
        helm-ff-auto-update-initial-value t
        helm-ff--auto-update-state t
        helm-M-x-fuzzy-match 		t
        helm-scroll-amount 		4 ; scroll 4 lines other window using M-<next>/M-<prior>
        helm-ff-search-library-in-sexp t ; search for library in `require' and
                                        ; `declare-function' sexp.
        helm-split-window-in-side-p t    ; open helm buffer inside current window,
                                        ; not occupy whole other window
        helm-candidate-number-limit 500  ; limit the number of displayed canidates
        helm-ff-file-name-history-use-recentf t
        helm-move-to-line-cycle-in-source t ; move to end or beginning of source
                                        ; when reaching top or bottom of source.
        helm-buffers-fuzzy-matching t     ; fuzzy matching buffer names when non-nil
                                        ; useful in helm-mini that lists buffers
        helm-recent-fuzzy-match 	t
        helm-apropos-fuzzy-match 	t       ; enable fuzzy matching
        )
  :config
  (require 'helm-descbinds)
  (require 'helm-ls-git)
  (require 'helm-themes)
  (require 'shell)
  (progn
    (helm-mode 1)
    (helm-adaptive-mode 1)
    ;; Helm Descbinds provides an interface to emacs’ describe-bindings making the currently active
    ;; key bindings interactively searchable with helm.
    (helm-descbinds-mode))

  ;; With helm-man-woman, you can quickly jump to any man entry Using Helm Interface,
  ;; Either by typing in Helm prompt or if point is on a symbol, get a man page at point.
  ;; To enable man page at point, add the following code:
  (add-to-list 'helm-sources-using-default-as-input 'helm-source-man-pages)


  ;; The default "C-x c" is quite close to "C-x C-c", which quits Emacs.
  ;; Changed to "C-c h". Note: We must set "C-c h" globally, because we
  ;; cannot change `helm-command-prefix-key' once `helm-config' is loaded.
  ;;(global-set-key (kbd "C-c h") 'helm-command-prefix)
  ;;(global-unset-key (kbd "C-x c"))


  ;; rebihnd tab to do persistent action
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action)

  ;; make TAB works in terminal
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action)

  ;; list actions using C-z
  (define-key helm-map (kbd "C-z")  'helm-select-action)

  ;; (define-key helm-grep-mode-map (kbd "<return>")  'helm-grep-mode-jump-other-window)
  ;; (define-key helm-grep-mode-map (kbd "n")  'helm-grep-mode-jump-other-window-forward)
  ;; (define-key helm-grep-mode-map (kbd "p")  'helm-grep-mode-jump-other-window-backward)

  (when (executable-find "curl")
    (setq helm-google-suggest-use-curl-p t))


  ;; live grep
  (when (executable-find "ack-grep")
    (setq helm-grep-default-command "ack-grep -Hn --no-group --no-color %e %p %f"
          helm-grep-default-recurse-command "ack-grep -H --no-group --no-color %e %p %f"))


  ;; (global-set-key (kbd "M-x") 		'helm-M-x)
  ;; (global-set-key (kbd "M-y") 		'helm-show-kill-ring)
  ;; (global-set-key (kbd "C-x b") 		'helm-mini)
  ;; (global-set-key (kbd "C-x C-f") 	'helm-find-files)
  ;; (global-set-key (kbd "C-h SPC") 	'helm-all-mark-rings)
  ;; ;;(global-set-key (kbd "C-c h o") 	'helm-occur)
  ;; (global-set-key (kbd "M-y")		'helm-show-kill-ring)


  ;;(global-set-key (kbd "C-c h C-c w") 	'helm-wikipedia-suggest)

  ;; (global-set-key (kbd "C-c h x") 	'helm-register)
  ;; (global-set-key (kbd "C-x r j") 'jump-to-register)

  ;; (define-key 'help-command (kbd "C-f") 'helm-apropos)
  ;; (define-key 'help-command (kbd "C-l") 'helm-locate-library)

;;; Save current position to mark ring
  (add-hook 'helm-goto-line-before-hook 'helm-save-current-pos-to-mark-ring)

  ;; show minibuffer history with Helm
  ;; (define-key minibuffer-local-map (kbd "M-p") 'helm-minibuffer-history)
  ;; (define-key minibuffer-local-map (kbd "M-n") 'helm-minibuffer-history)

  ;; (define-key global-map [remap find-tag] 'helm-etags-select)

  ;; (define-key global-map [remap list-buffers] 'helm-buffers-list)

  :diminish helm-mode
  :bind   (("M-x" 		. helm-M-x)
	   ("M-y" 		. helm-show-kill-ring) ;; replace yank-pop
	   ("C-c h" 	. helm-command-prefix)
	   ("C-h SPC" 	. helm-all-mark-rings)
	   ("C-x C-f" 	. helm-find-files)
	   ("C-x C-b" 	. helm-buffers-list)
	   ("C-x b" 	. helm-mini)
	   ("M-/" 		. helm-dabbrev)
	   ;; ("C-c f"		. helm-recentf)
	   ("C-h r"		. helm-info-emacs)
	   ("M-s o"		. helm-occur)
	   ("M-s g"		. helm-google-suggest)
	   ;; ("C-c C-l"	. helm-comint-input-ring)
	   ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; PACKAGE: helm-swoop                ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Locate the helm-swoop folder to your path
(use-package helm-swoop
  :config
  (setq helm-multi-swoop-edit-save t
        ;; If this value is t, split window inside the current window
        helm-swoop-split-with-multiple-windows t
        ;; Split direcion. 'split-window-vertically or 'split-window-horizontally
        helm-swoop-split-direction 'split-window-vertically
        ;; If nil, you can slightly boost invoke speed in exchange for text color
        helm-swoop-speed-or-color t)
  :bind
  ;; Change the keybinds to whatever you like :)
  (("M-s s i" . helm-occur-from-isearch)
   ("M-s s a" . helm-multi-swoop-all)))


;; (helm-mode 1)

(provide 'config-helm)
