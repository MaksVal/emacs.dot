(require 'jabber)

(setq
  special-display-regexps
  '(("jabber-chat"
      (width . 80)
     (scroll-bar-width . 16)
     (height . 15)
     (tool-bar-lines . 0)
     (menu-bar-lines 0)
     (font . "-GURSoutline-Courier New-normal-r-normal-normal-11-82-96-96-c-70-iso8859-1")
     (left . 80))))

(defun jabber ()
  (interactive)
  (require 'jabber)
  (define-key jabber-chat-mode-map [escape]
    'my-jabber-chat-delete-or-bury)

  (define-key mode-specific-map "jr"
    (lambda ()
      (interactive)
      (switch-to-buffer "*-jabber-*")))

  (define-key mode-specific-map "jc"
    '(lambda ()
       (interactive)
       (call-interactively 'jabber-connect)))

  (define-key mode-specific-map "jd"
    '(lambda ()
       (interactive)
       (call-interactively 'jabber-disconnect)))

  (define-key mode-specific-map "jj"
    '(lambda ()
       (interactive)
 (call-interactively 'jabber-chat-with)))

  (define-key mode-specific-map "ja"
    '(lambda ()
       (interactive)
       (jabber-send-presence "away" "" 10)))

  (define-key mode-specific-map "jo"
    '(lambda ()
       (interactive)
       (jabber-send-presence "" "" 10)))

  (define-key mode-specific-map "jx"
    '(lambda ()
       (interactive)
       (jabber-send-presence "xa" "" 10)))

  (jabber-connect))

(defun my-jabber-chat-delete-or-bury ()
  (interactive)
  (if (eq 'jabber-chat-mode major-mode)
      (condition-case e
          (delete-frame)
        (error
         (if (string= "Attempt to delete the sole visible or iconified frame"
                      (cadr e))
	     (bury-buffer))))))

(setq
 jabber-history-enabled t
 jabber-use-global-history nil
 jabber-backlog-number 40
 jabber-backlog-days 30
 )

;;(add-hook 'jabber-alert-message-hooks 'jabber-message-xmessage)

(setq jabber-xosd-display-time 5)

(defun jabber-xosd-display-message (message)
  "Displays MESSAGE through the xosd"
  (let ((process-connection-type nil))
    (start-process "jabber-xosd" nil "osd_cat" "-p" "bottom" "-A" "center" "-f" "-*-courier-*-*-*-*-30" "-d" (number-to-string jabber-xosd-display-time))
    (process-send-string "jabber-xosd" message)
    (process-send-eof "jabber-xosd")))

(defun jabber-message-xosd (from buffer text propsed-alert)
  (jabber-xosd-display-message "New message."))

(add-to-list 'jabber-alert-message-hooks 'jabber-message-xosd)

;; Show your status in the header
(setq jabber-chat-header-line-format
      '(" " (:eval (jabber-jid-displayname jabber-chatting-with))
    	" " (:eval (jabber-jid-resource jabber-chatting-with)) "\t";
    	(:eval (let ((buddy (jabber-jid-symbol jabber-chatting-with)))
    		 (propertize
    		  (or
    		   (cdr (assoc (get buddy 'show) jabber-presence-strings))
    		   (get buddy 'show))
    		  'face
    		  (or (cdr (assoc (get buddy 'show) jabber-presence-faces))
    		      'jabber-roster-user-online))))
    	"\t" (:eval (get (jabber-jid-symbol jabber-chatting-with) 'status))
    	(:eval (unless (equal "" *jabber-current-show*)
    		 (concat "\t You're " *jabber-current-show*
    			 " (" *jabber-current-status* ")")))))

;; AutoSmiley mode
(require 'autosmiley)
(add-hook 'jabber-chat-mode-hook 'autosmiley-mode)


;; Viewing histories
(defun jabber-visit-history (jid)
  "Visit jabber history with JID in a new buffer.

Performs well only for small files.  Expect to wait a few seconds
for large histories.  Adapted from `jabber-chat-create-buffer'."
  (interactive (list (jabber-read-jid-completing "JID: ")))
  (let ((buffer (generate-new-buffer (format "*-jabber-history-%s-*"
                                             (jabber-jid-displayname jid)))))
    (switch-to-buffer buffer)
    (make-local-variable 'jabber-chat-ewoc)
    (setq jabber-chat-ewoc (ewoc-create #'jabber-chat-pp))
    (mapc 'jabber-chat-insert-backlog-entry
          (nreverse (jabber-history-query nil nil t t "."
                                          (jabber-history-filename jid))))
    (view-mode)))
;; Try this line rather than the add-to-list above
;; if you experience problem on init
;; (add-hook 'jabber-alert-message-hooks 'jabber-message-xosd)

;; Debug
(setq jabber-debug-log-xml t)
(setq jabber-debug-keep-process-buffers t)

(provide 'jabber)
