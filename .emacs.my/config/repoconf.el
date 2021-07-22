;; Repository
(require 'package) 		;; You might already have this line
(setq package-archives '(
                         ("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("org" . "http://orgmode.org/elpa/") ; Org-mode's repository
                         ("SC"  . "http://joseito.republika.pl/sunrise-commander/")
                         ) )

(package-initialize) ;; You might already have this line

(provide 'repoconf)
