;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;; My KEY BINDING ;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load-library "hideshow")

(global-set-key "\C-c\l" 'revert-buffer-with-coding-system)

;; uncomment region ;;;;;;;;;;;;;;
(global-set-key "\C-cc" 'comment-or-uncomment-region) ;uncomment-region)

;; Display Menu ;;;;;;;;;;;;;;
(global-set-key "\C-cm"  'buffer-menu)

;; Menu bar
(global-set-key (kbd "C-S-m") 'menu-bar-mode)

;;;;;;;;;;;;;;;; HiseShow ;;;;;;;;;;;;;;;;;;
(defun hs-hide-hook ()
  (local-set-key (kbd "C-c <right>") 'hs-show-block)
  (local-set-key (kbd "C-c <left>")  'hs-hide-block)
  (local-set-key (kbd "C-c <up>")    'hs-hide-all)
  (local-set-key (kbd "C-c <down>")  'hs-show-all)
  (hs-minor-mode t)
  )
;;
(add-hook 'c-mode-common-hook
	  (lambda()
	    (local-set-key (kbd "C-c <right>") 'hs-show-block)
	    (local-set-key (kbd "C-c <left>")  'hs-hide-block)
	    (local-set-key (kbd "C-c <up>")    'hs-hide-all)
	    (local-set-key (kbd "C-c <down>")  'hs-show-all)
	    (hs-minor-mode t)
	    ))
;;;;;;;;;;;;; END HideShow ;;;;;;;;;;;;;;;


;; Start and Stop TIMER ORG MODE in TODO list
(global-set-key "\C-c\C-x\ ,"  'org-timer-pause-or-continue)

(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)

;; Magit status
(global-set-key (kbd "\C-c\C-x m") 'magit-status)

;; Man pages
(global-set-key (kbd "<f1>") 'man)

(provide 'keybindsconf)
;;;;;;;;;;;;; END KEY BINDING ;;;;;;;;;;;;;;
