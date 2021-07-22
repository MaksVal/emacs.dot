;; (require 'popup-switcher)
;; (global-set-key [f2] 'psw-switch-buffer)
;; (setq psw-use-flx t)

;; (defcustom complete-in-region-use-popup nil
;;   "If non-NIL, complete-in-region will popup a menu with the possible completions."
;;   :type 'boolean
;;   :group 'completion)
;; (autoload 'popup-menu* "popup" "Show a popup menu" nil)
;; (defun popup-complete-in-region (next-func start end collection &optional predicate)
;;   (if (not complete-in-region-use-popup)
;;       (funcall next-func start end collection predicate)
;;     (let* ((prefix (buffer-substring start end))
;; 	   (completion (try-completion prefix collection predicate))
;; 	   (choice (and (stringp completion)
;; 			(string= completion prefix)
;; 			(popup-menu* (all-completions prefix collection predicate))))
;; 	   (replacement (or choice completion))
;; 	   (tail (and (stringp replacement)
;; 		      (not (string= prefix replacement))
;; 		      (substring replacement (- end start)))))
;;       (cond ((eq completion t)
;; 	     (goto-char end)
;; 	     (message "Sole completion")
;; 	     nil)
;; 	    ((null completion)
;; 	     (message "No match")
;; 	     nil)
;; 	    (tail
;; 	     (goto-char end)
;; 	     (insert tail)
;; 	     t)
;; 	    (choice
;; 	     (message "Nothing to do")
;; 	     nil)
;; 	    (t
;; 	     (message "completion: something failed!")
;; 	     (funcall next-func start end collection predicate))))))
;; (add-hook 'completion-in-region-functions 'popup-complete-in-region)
;; ;; (provide 'popup-complete)

;; (setq popup-complete-enable 			t
;;       popup-complete-enabled-modes 		nil
;;       popup-use-optimized-column-computation 	nil)


(provide 'popup)
