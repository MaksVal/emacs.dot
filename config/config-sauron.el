(require 'sauron)

 ;; note, you add (setq sauron-debug t) to get errors which can debug if
 ;; there's something wrong; normally, we catch such errors, since e.g an error
 ;; in one of the hooks may cause ERC to fail (i.e., the message won't come
 ;; trough).

(global-set-key (kbd "C-c s") 'sauron-toggle-hide-show)
(global-set-key (kbd "C-c t") 'sauron-clear)

(setq
 sauron-modules '(sauron-dbus sauron-org sauron-notifications))

(setq
  sauron-max-line-length 120

  ;; uncomment to show sauron in the current frame
  sauron-separate-frame nil

  ;; you probably want to add your own nickname to the these patterns
  sauron-watch-patterns
  '("emacs-fu" "emacsfu" "wombat" "capybara" "yak" "gnu" "\\bmu\\b" "mail")

  ;; you probably want to add you own nick here as well
  sauron-watch-nicks
  '("mgordeev" "MaksVal" "m.gordeev"))

;; some sound/light effects for certain events
(add-hook 'sauron-event-added-functions
  (lambda (origin prio msg &optional props)
    (if (string-match "ping" msg)
      (sauron-fx-sox "/usr/share/sounds/ping.wav"))
    (cond
      ((= prio 3) (sauron-fx-sox "/usr/share/sounds/pop.wav"))
      ((= prio 4) (sauron-fx-sox "/usr/share/sounds/pop.wav"))
      ((= prio 5)
	(sauron-fx-sox "/usr/share/sounds/pop.wav")
	(sauron-fx-gnome-osd(format "%S: %s" origin msg) 5)))))

;; events to ignore
(add-hook 'sauron-event-block-functions
  (lambda (origin prio msg &optional props)
    (or
     (string-match "^*** Users" msg)))) ;; filter out IRC spam

(setq sauron-dbus-cookie t)

(provide 'config-sauron)
