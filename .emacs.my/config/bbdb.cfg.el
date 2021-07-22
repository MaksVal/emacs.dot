;; bbdb
(require 'bbdb)
;; (bbdb-initialize)
(bbdb-initialize 'message 'mu4e)
;; (add-hook ‘gnus-startup-hook ‘bbdb-insinuate-gnus) (require ‘message-x)
;; (add-hook 'gnus-startup-hook 'bbdb-insinuate-message) (require 'message-x)

;; (setq
;;  bbdb-default-country nil
;;  bbdb-debug nil
;;  ;; bbdb-file "~/.bbdb"
;;  bbdb-completion-display-record nil
;;  bbdb-quiet-about-name-mismatches 0

;;  bbdb-mail-user-agent (quote message-user-agent)
;;  bbdb-offer-save 1                        ;; 1 means save-without-asking


;;  bbdb-use-pop-up t                        ;; allow popups for addresses
;;  bbdb-electric-p t                        ;; be disposable with SPC
;;  bbdb-popup-target-lines  1               ;; very small

;;  bbdb-dwim-net-address-allow-redundancy t ;; always use full name
;;  bbdb-quiet-about-name-mismatches 2       ;; show name-mismatches 2 secs

;;  bbdb-always-add-address t                ;; add new addresses to existing...
;;  ;; ...contacts automatically
;;  bbdb-canonicalize-redundant-nets-p t     ;; x@foo.bar.cx => x@bar.cx

;;  bbdb-completion-type t                   ;; complete on anything

;;  bbdb-complete-name-allow-cycling t       ;; cycle through matches
;;  ;; this only works partially

;;  bbbd-message-caching-enabled t           ;; be fast
;;  ;;  bbdb-use-alternate-names t               ;; use AKA


;;  bbdb-elided-display t                    ;; single-line addresses

;;  ;; auto-create addresses from mail
;;  bbdb/mail-auto-create-p 'bbdb-ignore-some-messages-hook
;;  bbdb-ignore-some-messages-alist ;; don't ask about fake addresses
;;  ;; NOTE: there can be only one entry per header (such as To, From)
;;  ;; http://flex.ee.uec.ac.jp/texi/bbdb/bbdb_11.html
;;  )

(bbdb-mua-auto-update-init 'message 'mu4e)
(setq bbdb/mail-auto-create-p t
      bbdb/news-auto-create-p t
      bbdb/srv-auto-create-p t
      bbdb-update-records-p 'create
                                        ;-
      bbdb-file-coding-system 'utf-8
      bbdb-display-layout 'multi-line
      ;; (setq bbdb-pop-up-target-lines 1)
      ;; (setq bbdb-north-american-phone-numbers-p nil)

      bbdb/mail-auto-create-p 'bbdb-ignore-some-messages-hook

      ;; (setq bbdb-ignore-most-messages-alist (quote (("To" . "sacha") ("Cc" . "sacha") ("To" "emacs-wiki-discuss") ("To" . "yoh@\\|yarik@\\|yaroslav@"))))

      mu4e-view-mode-hook (quote (bbdb-mua-auto-update visual-line-mode))
      mu4e-compose-complete-addresses nil
      bbdb-mua-pop-up t
      bbdb-mua-pop-up-window-size 5)

(let ((m (assq 'message bbdb-mua-mode-alist)))
  (unless (memq 'mu4e-compose-mode (cdr m))
    (setcdr m (cons 'mu4e-compose-mode (cdr m)))))


(provide 'bbdb.cfg)
