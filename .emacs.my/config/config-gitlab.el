(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

;; (add-to-list 'load-path "~/Projects/emacs-gitlab")
;; (load "gitlab")

(use-package gitlab
  :disable
  :config
  ;; Gitlab
  (global-set-key (kbd "\C-c\C-x g i") 'helm-gitlab-issues)
  (global-set-key (kbd "\C-c\C-x g p") 'helm-gitlab-projects)

  (use-package helm-gitlab)
  )

(require 'cl)
(require 'org)

(defun gitlab-issue-status-to-org (issue)
  (cond ((string= (assoc-default 'state issue) "opened")
         (if (assoc-default 'assignee issue)
             "NEXT"
           "TODO"))
        ;; ((string= (assoc-default 'state issue) "active")
        ;;  "NEXT")
        ((string= (assoc-default 'state issue) "closed")
         "DONE")
        (t (assoc-default 'state issue))))


(defun gitlab-to-org ()
  (interactive)
  (with-temp-buffer
    (mapc (lambda (project)
            (insert "* " (assoc-default 'name project))
            (end-of-line) (newline)
            (insert "#+CATEGORY: Gitlab")
            (end-of-line) (newline)
            (mapc (lambda (milestone)
                    (insert "** " (assoc-default 'title milestone))
                    (end-of-line) (newline)
                    (mapc (lambda (issue)
                            (insert "*** "
                                    (gitlab-issue-status-to-org issue)
                                    " "
                                    "[[gitlab:/"
                                    (assoc-default 'path_with_namespace project)
                                    "/issues/"
                                    (number-to-string (assoc-default 'id issue))
                                    "]["
                                    "#"
                                    (number-to-string (assoc-default 'id issue))
                                    " "
                                    (assoc-default 'title issue)
                                    "]]")
                            (end-of-line) (newline)
                            (insert "    DEADLINE: <"
                                    (assoc-default 'due_date milestone)
                                    ">")
                            (when (assoc-default 'assignee issue)
                              (end-of-line) (newline)
                              (insert "    :PROPERTIES:")
                              (end-of-line) (newline)
                              (insert "    :assigned:"
                                      (assoc-default 'name
                                                     (assoc-default 'assignee issue)))
                              (end-of-line) (newline)
                              (insert "    :END:"))
                            (end-of-line) (newline))
                          (gitlab-get-milestone-issues (assoc-default 'id project)
                                                       (assoc-default 'id milestone))))
                  (gitlab-list-project-milestones (assoc-default 'id project)))
            (insert "** ALL")
            (end-of-line) (newline)
            (mapc (lambda (issue)
                    (unless (assoc-default 'milestone issue)
                      (insert "** "
                              (gitlab-issue-status-to-org issue)
                              " "
                              (assoc-default 'title issue))
                      (end-of-line) (newline)))
                  (gitlab-list-all-project-issues (assoc-default 'id project))))
          (gitlab-list-projects))
    (end-of-line) (newline)
    (end-of-line) (newline)
    (insert "#+LINK: gitlab  " gitlab-host)
    (buffer-string)))


(defun emacs-gitlab-to-org-file ()
  (interactive)
  (let ((file "~/ORG/gitlab.org"))
    (with-temp-file file
      (insert (gitlab-to-org)))))

(provide 'config-gitlab)
