;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; MU
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'mu4e)
(require 'mu4e-maildirs-extension)
(require 'mu4e-alert)

;; mu4e as default email agent in emacs
(setq mail-user-agent 'mu4e-user-agent)

;; All folder in main buffer
(mu4e-maildirs-extension)


;; ;; Counter - unread message in menu-line
(mu4e-alert-set-default-style 'libnotify)
(add-hook 'after-init-hook 'mu4e-alert-enable-mode-line-display)
(add-hook 'after-init-hook #'mu4e-alert-enable-notifications)

;; (alert-add-rule :category "mu4e-alert" :style 'fringe :predicate (lambda (_) (string-match-p "^mu4e-" (symbol-name major-mode))) :continue t)
;; (setq mu4e-alert-notify-repeated-mails t)
;; (mu4e-alert-enable-notifications)

(setq languages
     ;; dictionary . locale
      '(("russian" . "ru_RU.utf8")
        ("english" . "en_US.utf8")))

;; where i store my mail
(setq mu4e-maildir "~/.mail")
(setq rmail-file-name "~/.mail")

;; update every 5 minutes
;; allow for updating mail using 'U' in the main view:
;; (setq mu4e-get-mail-command "offlineimap")  ;; or fetchmail, or ...
;; (setq mu4e-update-interval 30)

(run-at-time nil 30 'mu4e-update-index)
(setq mu4e-hide-index-messages 1)

;; use imagemagick, if available
(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))

;; enable inline images
;; attempt to show images when viewing messages
(setq mu4e-view-show-images t
      mu4e-show-images t
      mu4e-view-image-max-width 800)

(add-hook 'mu4e-view-mode-hook
          (lambda ()
            (setq mu4e-view-show-images t)))

(when (fboundp 'imagemagick-register-types)
  (imagemagick-register-types))


;; mu4e to auto-update every time you go to the main view
(defun my-mu4e-maildirs-extension-always-update ()
  (mu4e-maildirs-extension-force-update '(1)))

(add-hook 'mu4e-main-mode-hook 'my-mu4e-maildirs-extension-always-update)
;; (add-hook 'mu4e-index-updated-hook
;;           (defun new-mail-sound ()
;;             ((shell-command "play /usr/share/sounds/KDE-Im-New-Mail.ogg&")))


;; Handling errors during mail retrieval
;; (setq mu4e-get-mail-command "fetchmail -v || [ $? -eq 1 ]")

(setq mu4e-drafts-folder "/Черновики"
      mu4e-sent-folder   "/Отправленные"
      mu4e-trash-folder  "/Корзина"
      mu4e-refile-folder "/Архивы")   ;; saved messages

;; setup some handy shortcuts
;; you can quickly switch to your Inbox -- press ``ji''
;; then, when you want archive some messages, move them to
;; the 'All Mail' folder by pressing ``ma''.
(setq mu4e-maildir-shortcuts
      '( ("/INBOX"	        . ?i)
         ("/Отправленные" 	. ?s)
         ("/Корзина"      	. ?t)
         ("/Все сообщения"	. ?a)))

(setq mu4e-sent-messages-behavior 'sent)

;; Hooks
(add-hook 'message-mode-hook (lambda () (flyspell-mode 1))) ;; spellcheck
(add-hook 'mu4e-compose-mode-hook flyspell-mode)
;; (add-hook 'mu4e-compose-mode-hook (lambda ()  (use-hard-newlines t 'guess))) ;; format=flowed

;;(require 'visual-fill-column)
(add-hook 'mu4e-compose-mode-hook
          (lambda ()
            (set-fill-column 72)
            (auto-fill-mode 0)
            (visual-fill-column-mode)
            (setq visual-line-fringe-indicators '(left-curly-arrow right-curly-arrow))
            (visual-line-mode)))



;; (defun my-mu4e-choose-signature ()
;;   "Insert one of a number of sigs"
;;   (interactive)
;;   (let ((message-signature
;;          (mu4e-read-option "Signature:"
;;                            '(("formal" .
;;                               (concat
;;                                "Joe Bloggs\n"
;;                                "Department, Company Name, Country\n"
;;                                "W: http://www.example.com\n"))
;;                              ("informal" .
;;                               "JoeC\n")))))
;;     (message-insert-signature)))

;; (add-hook 'mu4e-compose-mode-hook
;;           (lambda () (local-set-key (kbd "C-c C-w") #'my-mu4e-choose-signature)))



;; sending mail -- replace USERNAME with your gmail username
;; also, make sure the gnutls command line utils are installed
;; package 'gnutls-bin' in Debian/Ubuntu


;; (setq message-send-mail-function 'smtpmail-send-it
;;       starttls-use-gnutls t
;;       smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
;;       smtpmail-auth-credentials
;;       '(("smtp.gmail.com" 587 "renws1990@gmail.com" nil))
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587)

;; alternatively, for emacs-24 you can use:
;; (setq message-send-mail-function 'smtpmail-send-it
;;       smtpmail-stream-type 'starttls
;;       smtpmail-default-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-server "smtp.gmail.com"
;;       smtpmail-smtp-service 587

;;       ;; if you need offline mode, set these -- and create the queue dir
;;       ;; with 'mu mkdir', i.e.. mu mkdir /home/user/Maildir/queue
;;       smtpmail-queue-mail  nil
;;       smtpmail-queue-dir  "~/.mail/queue/cur")


;; don't keep message buffers around
(setq message-kill-buffer-on-exit t)

;; (defun my-mu4e-sent-folder-function (msg)
;;   "Set the sent folder for the current message."
;;   (let ((from-address (message-field-value "From"))
;;         (to-address (message-field-value "To")))
;;     (cond
;;      ((string-match "my.address@account1.example.com" from-address)
;;       (if (member* to-address my-mu4e-mailing-lists
;;                    :test #'(lambda (x y)
;;                              (string-match (car y) x)))
;;           "/Trash"
;;         "/Account1/Sent"))
;;      ((string-match "my.address@gmail.com" from-address)
;;       "/Gmail/Sent Mail")
;;      (t (mu4e-ask-maildir-check-exists "Save message to maildir: ")))))


(require 'mu4e-contrib)

;; (add-hook 'mu4e-view-mode-hook
;;   (lambda()
;;     ;; try to emulate some of the eww key-bindings
;;     (local-set-key (kbd "<tab>") 'shr-next-link)
;;     (local-set-key (kbd "<backtab>") 'shr-previous-link)))

(setq shr-color-visible-luminance-min 80)

;; ref: http://emacs.stackexchange.com/questions/3051/how-can-i-use-eww-as-a-renderer-for-mu4e
;; (defun mimedown ()
;;   (interactive)
;;   (save-excursion
;;     (message-goto-body)
;;     (shell-command-on-region (point) (point-max) "mimedown" nil t)))


(defun my-render-html-message ()
  (let ((dom (libxml-parse-html-region (point-min) (point-max))))
    (erase-buffer)
    (shr-insert-document dom)
    (shr-insert-image)

    (goto-char (point-min))))

;; (setq mu4e-html2text-command 'mimedown)
;; (setq mu4e-html2text-command 'my-render-html-message)
;; when you want to use some external command for text->html
;; conversion, e.g. the 'html2text' program
;; (setq mu4e-html2text-command "html2text -utf8 -width 72")
;; (setq mu4e-html2text-command 'mu4e-shr2text)
;; (setq mu4e-html2text-command 'html-to-markdown)
;; (setq mu4e-html2text-command "w3m -T text/html")
;; (setq mu4e-html2text-command "lynx -dump -")
(setq mu4e-html2text-command "lynx -stdin -dump -width=75")
;; (setq mu4e-html2text-command "tee /tmp/`date +%s`.html")
 ;; (setq mu4e-html2text-command "sed s/'charset=koi8-r'/'charset=utf-8'/ $1 | w3m -T text/html")

;; View settings
(setq mu4e-view-prefer-html t)
(setq mu4e-use-fancy-chars t)
(setq mu4e-view-show-addresses t)

;; yt
(add-to-list 'mu4e-view-actions
             '("ViewInBrowser" . mu4e-action-view-in-browser) t) ;; read in browser

;; give me ISO(ish) format date-time stamps in the header list
(setq  mu4e-headers-date-format "%Y-%m-%d %H:%M")

;; customize the reply-quote-string
;; M-x find-function RET message-citation-line-format for docs
(setq message-citation-line-format "%N @ %Y-%m-%d %H:%M %Z:\n")
(setq message-citation-line-function 'message-insert-formatted-citation-line)


(setq mu4e-attachment-dir  "~/Downloads")

(global-set-key (kbd "<f9> e") 'helm-mu)



(require 'org-mu4e)
                                        ;== M-x org-mu4e-compose-org-mode==
(setq org-mu4e-convert-to-html t) 	    ;; org -> html
                                        ; = M-m C-c.=

;;store link to message if in header view, not to header query
(setq org-mu4e-link-query-in-headers-mode nil)

;; Headers
(setq mu4e-headers-fields (quote ((:human-date . 16 )
                                  (:flags . 3)
                                  ;; (:mailing-list . 6)
                                  (:from-or-to . 22)
                                  (:subject))))

(setq mu4e-msg2pdf "/usr/local/bin/msg2pdf")


;;;; Search from HELM
;;;; When you press s in Mu4e, this starts a new search.
;;;; If you want to replace Mu4e’s search function by helm-mu
(define-key mu4e-main-mode-map "s" 'helm-mu)
(define-key mu4e-headers-mode-map "s" 'helm-mu)
(define-key mu4e-view-mode-map "s" 'helm-mu)

;;;; The default search string is the empty string.
;;;; This means that if you fire up helm-mu, initially you see all emails from all mailboxes.
(setq helm-mu-default-search-string "(maildir:/INBOX OR maildir:/Отправленные)")

;;;; Some people only send you emails through mailing lists.
;; (setq helm-mu-contacts-personal t)

;;;; Address auto-completion
(require 'popup)
 (require 'bbdb.cfg)
;; (defun my/select-and-insert-contact ()
;;   (interactive)
;;   (let ((contact (popup-menu* mu4e~contacts-for-completion)))
;;     (insert contact)))
 (define-key message-mode-map (kbd "C-c C-f c") 'helm-mu-contacts)

;; (helm-comp-read "Complete contact: " (mu4e~compose-complete-contact)))))
;; (ido-completing-read "Complete contact: " (mu4e~compose-complete-contact)))))

 ;; (defun select-and-insert-contact ()
 ;;   (interactive)
 ;;   (insert  ;; (ido-completing-read "Contact: " mu4e~contacts-for-completion)))
 ;;    (helm-comp-read "Complete contact: " mu4e~compose-complete-contact)))

;; (defun select-and-insert-contact (&optional start)
;;   (interactive)
;;   (let ((mail-abbrev-mode-regexp mu4e~compose-address-fields-regexp)
;;         (eoh ;; end-of-headers
;;          (save-excursion
;;            (goto-char (point-min))
;;            (search-forward-regexp mail-header-separator nil t))))
;;     (when (and eoh (> eoh (point)) (mail-abbrev-in-expansion-header-p))
;;       (let* ((end (point))
;;              (start
;;               (or start
;;                   (save-excursion
;;                     (re-search-backward "\\(\\`\\|[\n:,]\\)[ \t]*")
;;                     (goto-char (match-end 0))
;;                     (point))))
;;              (contact
;;               (ido-completing-read "Contact: "
;;                                    mu4e~contacts-for-completion
;;                                    nil
;;                                    nil
;;                                    (buffer-substring-no-properties start end))))
;;         (unless (equal contact "")
;;           (kill-region start end)
;;           (insert contact))))))

(add-hook 'mu4e-compose-mode-hook
          (lambda()
            ;; try to emulate some of the eww key-bindings
            (local-set-key (kbd "C-c C-x o") 'org-mu4e-compose-org-mode)))

;;(require 'org-contacts)
;; (setq mu4e-org-contacts-file " ~/.mail/contacts.org")
;; (add-to-list 'mu4e-headers-actions
;;   '("org-contact-add" . mu4e-action-add-org-contact) t)
;; (add-to-list 'mu4e-view-actions
;;              '("org-contact-add" . mu4e-action-add-org-contact) t)
;; (setq mu4e-compose-complete-only-personal t)
;; (add-to-list 'helm-mode-no-completion-in-region-in-modes 'mu4e-compose-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END MU
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;; (require 'ldap)
;; (require 'eudc)

;; (setq eudc-default-return-attributes nil
;;       eudc-strict-return-matches nil)

;; (setq ldap-ldapsearch-args (quote ("-tt" "-LLL" "-x")))
;; (setq eudc-inline-query-format '((name)
;;                                  (firstname)
;;                                  (firstname name)
;;                                  (email)
;;                                  ))

;; (eudc-set-server "your_server" 'ldap t)
;; (setq eudc-server-hotlist '(("your_server" . ldap)))
;; (setq eudc-inline-expansion-servers 'hotlist)

;; (defun enz-eudc-expand-inline()
;;   (interactive)
;;   (move-end-of-line 1)
;;   (insert "*")
;;   (unless (condition-case nil
;;               (eudc-expand-inline)
;;             (error nil))
;;     (backward-delete-char-untabify 1))
;;   )

;; ;; Adds some hooks

;; (eval-after-load "message"
;;   '(define-key message-mode-map (kbd "TAB") 'enz-eudc-expand-inline))
;; (eval-after-load "sendmail"
;;   '(define-key mail-mode-map (kbd "TAB") 'enz-eudc-expand-inline))
;; (eval-after-load "post"
;;   '(define-key post-mode-map (kbd "TAB") 'enz-eudc-expand-inline))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; NOTMUCH
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; (autoload 'notmuch "notmuch" "notmuch mail" t)
;; (require 'notmuch)
;; (require 'gnus-art)

;; ;;(setq mm-text-html-renderer 'w3m) ;; html2text causes tagging to stop working
;; (setq notmuch-fcc-dirs nil) ; Gmail saves sent mails by itself

;; (define-key notmuch-show-mode-map (kbd "RET") 'goto-address-at-point)

;; ;; (global-set-key (kbd "C-c c g") 'notmuch)
;; (global-set-key (kbd "C-c n") (lambda ()
;;                                   (interactive)
;;                                   (notmuch-search "tag:inbox")))

;; ;; (define-key notmuch-search-mode-map "q" (lambda ()
;; ;;                                           (interactive)
;; ;;                                           (offlineimap)
;; ;;                                           (notmuch-search-quit)))
;; ;; (define-key notmuch-show-mode-map "q"
;; ;;   (lambda ()
;; ;;     (interactive)
;; ;;     (notmuch-kill-this-buffer)
;; ;;     (if (and (eq major-mode 'notmuch-search-mode)
;; ;;              (< (buffer-size) 1024))
;; ;;         (notmuch-search-refresh-view))))

;; (setq notmuch-saved-searches
;;       '(("inbox" . "tag:inbox")))

;; (defvar my-notmuch-move-options '(("personal" "INBOX.personal" "p")
;;                                   ("uni" "INBOX.uni" "u")
;;                                   ("trash" "[Gmail].Trash" "d"))
;;   "List of synced notmuch labels and Maildir folders. The format
;;     is '(notmuch-tag Maildir-folder key-binding). Key-binding
;;     is \"m x\" when viewing a message where x is the key-binding
;;     from the format.")

;; (defvar my-notmuch-remove-tags-on-move
;;   (append (mapcar 'car my-notmuch-move-options)
;;           '("inbox"))
;;   "Which tags to remove from messages when moving them.")

;; (define-key notmuch-show-mode-map (kbd "m") nil)
;; (require 'cl)
;; (dolist (opt my-notmuch-move-options)
;;   (lexical-let ((tag (car opt))
;;                 (binding (car (cdr (cdr opt)))))
;;     (define-key notmuch-show-mode-map (concat "m" binding)
;;       (function (lambda ()
;;                   (interactive)
;;                   (my-notmuch-move tag))))))

;; (defun my-notmuch-do-move (tag folder)
;;   (interactive)
;;   (notmuch-show-refresh-view)
;;   (let ((from (shell-quote-argument (notmuch-show-get-filename)))
;;         (to (shell-quote-argument folder)))
;;     (shell-command (concat "ln " from " " to))
;;     (shell-command (concat "rm " from))
;;     (dolist (cur-tag my-notmuch-remove-tags-on-move)
;;       (notmuch-show-tag-message (concat "-" cur-tag)))
;;     (notmuch-show-tag-message (concat "+" tag))))
;; (defun my-notmuch-move (&optional in-tag)
;;   (interactive)
;;   (let* ((tag (or in-tag
;;                   (completing-read "Move message to: "
;;                                    (mapcar 'car my-notmuch-move-options))))
;;          (folder (cadr (assoc tag my-notmuch-move-options)))
;;          (full-folder (concat my-notmuch-mail-path "/" folder "/cur/")))
;;     (if (null folder)
;;         (error "Unknown tag: %s" tag)
;;       (my-notmuch-do-move tag full-folder))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DEBUG MU4E
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'mu4e-index-updated-hook (lambda () (message "[mu4e-alert] Index updated")))

(defun mu4e-alert-notify-unread-mail-async ()
  "Send a desktop notification about currently unread email."
  (message "[mu4e-alert] Fetching unread emails")
  (mu4e-alert--get-mu-unread-mails (lambda (mails)
                                     (message "[mu4e-alert] Got %d emails" (length mails))
                                     (let ((new-mails (mu4e-alert-filter-repeated-mails mails)))
                                       (when (memql 'count mu4e-alert-email-notification-types)
                                         (mu4e-alert-notify-unread-messages-count (length new-mails)))
                                       (when (memql 'subjects mu4e-alert-email-notification-types)
                                         (mu4e-alert-notify-unread-messages new-mails))))))


(defun mu4e-alert-notify-unread-messages-count (mail-count)
  "Display desktop notification for given MAIL-COUNT."
  (message "[mu4e-alert] Alerting the user")
  (when (not (zerop mail-count))
    (alert (funcall mu4e-alert-email-count-notification-formatter
                    mail-count)
           :title mu4e-alert-email-count-title
           :category "mu4e-alert")))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; END
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'mail)
