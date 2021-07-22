;; (require 'org-caldav)
;; (require 'org-gcal)
;; (setq org-gcal-client-id "1055995268584-umhr71a77hca0glh1aecp39mr1v49upo.apps.googleusercontent.com"
;;       org-gcal-client-secret "4JnG12ndjrTr6YRD-VAT__3k"
;;       org-gcal-file-alist '(("tmofjm0e4469k390vdlf8o2mn8@group.calendar.google.com" . "~/ORG/OrgLendar.org")
;; 			    ("valmaxster@gmail.com" .  "~/ORG/valmaxster.org")
;;                             ;; ("another-mail@gmail.com" .  "~/task.org")
;; 			    ))


;; (setq org-caldav-url "https://www.google.com/calendar/ical/valmaxster%40gmail.com/private-d2c862159cef90c16f1f56e36b7139d0/basic.ics")
;; (setq org-caldav-calendar-id "Максим М")
;; (setq org-caldav-inbox (expand-file-name "~/ORG/valmaxster.org"))
;; (setq org-caldav-files `(,org-caldav-inbox))

(require 'orgconf)
(require 'filenotify)
(require 'org-mobile-sync)

;; (org-mobile-sync-mode nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;; Sync ORG MOBILE ;;;;;;;;;;;;;;;;;;;;;;;;;;
;; moble sync
;; (defvar org-mobile-sync-timer nil)
;; (defvar org-mobile-sync-idle-secs (* 60 10))
;; (defun org-mobile-sync ()
;;   (interactive)
;;   (org-mobile-pull)
;;   (message "org-mobile is updated."))
;; (defun org-mobile-sync-enable ()
;;   "enable mobile org idle sync"
;;   (message "enable mobile org idle sync")
;;   (interactive)
;;   (setq org-mobile-sync-timer
;;         (run-with-idle-timer org-mobile-sync-idle-secs t
;;                              'org-mobile-sync)));
;; (defun org-mobile-sync-disable ()
;;   "disable mobile org idle sync"
;;   (message "disable mobile org idle sync")
;;   (interactive)
;;   (cancel-timer org-mobile-sync-timer))

;; (org-mobile-sync-enable)



;; Fork the work (async) of pushing to mobile
;; https://gist.github.com/3111823 ASYNC org mobile push...
;; (require 'gnus-async)
;; Define a timer variable
;; (defvar org-mobile-push-timer nil
;;   "Timer that `org-mobile-push-timer' used to reschedule itself, or nil.")

;; Push to mobile when the idle timer runs out
;; (defun org-mobile-push-with-delay (secs)
;;    (when org-mobile-push-timer
;;     (cancel-timer org-mobile-push-timer))
;;   (setq org-mobile-push-timer
;;         (run-with-idle-timer
;;          (* 1 secs) nil 'org-mobile-push)))

;; After saving files, start an idle timer after which we are going to push
;; (add-hook 'after-save-hook
;;  (lambda ()
;;    (if (or (eq major-mode 'org-mode) (eq major-mode 'org-agenda-mode))
;;      (dolist (file (org-mobile-files-alist))
;;        (if (string= (expand-file-name (car file)) (buffer-file-name))
;;            (org-mobile-push)))
;;      )))
;; ;; Run after midnight each day (or each morning upon wakeup?).
;; (run-at-time "00:01" 86400 '(lambda () (org-mobile-push-with-delay 1)))
;; ;; Run 1 minute after launch, and once a day after that.
;; (run-at-time "1 min" 86400 '(lambda () (org-mobile-push-with-delay 1)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;  ORG Sync ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;

;; (require 'org-sync)
;; (require 'org-sync-redmine)
;; ;; this is the variable used in org-sync-backend-alist
;; (defvar org-sync-demo-backend
;;   '((base-url      . org-sync-demo-base-url)
;;     (fetch-buglist . org-sync-demo-fetch-buglist)
;;     (send-buglist  . org-sync-demo-send-buglist))
;;   "Demo backend.")


;; ;; this overrides org-sync--base-url.
;; ;; the argument is the url the user gave.
;; ;; it must return a cannonical version of the url that will be
;; ;; available to your backend function in the org-sync-base-url variable.

;; ;; In the github backend, it returns API base url
;; ;; ie. https://api.github/reposa/<user>/<repo>

;; (defun org-sync-demo-base-url (url)
;;   "Return proper URL."

;; ;; this overrides org-sync--fetch-buglist
;; ;; you can use the variable org-sync-base-url
;; (defun org-sync-demo-fetch-buglist (last-update)
;;   "Fetch buglist from demo.com (anything that happened after LAST-UPDATE)"
;;   ;; a buglist is just a plist
;;   `(:title "Stuff at demo.com"
;;            :url ,org-sync-base-url

;;            ;; add a :since property set to last-update if you return
;;            ;; only the bugs updated since it.  omit it or set it to
;;            ;; nil if you ignore last-update and fetch all the bugs of
;;            ;; the repo.

;;            ;; bugs contains a list of bugs
;;            ;; a bug is a plist too
;;            :bugs ((:id 1 :title "Foo" :status open :desc "bar."))))

;; ;; this overrides org-sync--send-buglist
;; (defun org-sync-demo-send-buglist (buglist)
;;   "Send BUGLIST to demo.com and return updated buglist"
;;   ;; here you should loop over :bugs in buglist
;;   (dolist (b (org-sync-get-prop :bugs buglist))
;;     (cond
;;       ;; new bug (no id)
;;       ((null (org-sync-get-prop :id b)
;;         '(do-stuff)))

;;       ;; delete bug
;;       ((org-sync-get-prop :delete b)
;;         '(do-stuff))

;;       ;; else, modified bug
;;       (t
;;         '(do-stuff))))

;;   ;; return any bug that has changed (modification date, new bugs,
;;   ;; etc).  they will overwrite/be added in the buglist in org-sync.el

;;   ;; we return the same thing for the demo.
;;   ;; :bugs is the only property used from this function in org-sync.el
;;   `(:bugs ((:id 1 :title "Foo" :status open :desc "bar."))))

(provide 'orgsync)
