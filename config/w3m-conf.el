(require 'w3m)

;; (setq w3m-charset-coding-system-alist
;;  	  (cons '(windows-1251 . cp1251)
;;  			(cons '(utf-8 . utf-8)
;;  				  (cons '(koi8-r . koi8-r)
;;  						w3m-charset-coding-system-alist)))
;; 	  )

;; (setq w3m-coding-system 'utf-8
;;       w3m-default-coding-system 'utf-8
;;       w3m-file-coding-system 'utf-8
;;       w3m-file-name-coding-system 'utf-8
;;       w3m-bookmark-file-coding-system 'utf-8
;;       w3m-input-coding-system 'utf-8
;;       w3m-output-coding-system 'utf-8
;;       w3m-terminal-coding-system 'utf-8
;;       w3m-google-feeling-lucky-charset 'utf-8)

;; (setq w3m-correct-charset-alist
;;       '(("cp1251" . "windows-1251")
;;         ("koi8-r" . "cyrillic-koi8")
;;         ("utf-8"  . "mule-utf-8")))

;; (setq w3m-charset-coding-system-alist
;;       '((cp1251 . windows-1251)
;;         (koi8-r . cyrillic-koi8)
;;         (utf-8  . mule-utf-8)
;;         (x-unknown . undecided)
;;         (unknown . undecided)
;;         (us_ascii . raw-text)))

(setq w3m-default-symbol
      '("─┼" " ├" "─┬" " ┌" "─┤" " │" "─┐" ""
        "─┴" " └" "──" ""   "─┘" ""   ""   ""
        "─┼" " ┠" "━┯" " ┏" "─┨" " ┃" "━┓" ""
        "━┷" " ┗" "━━" ""   "━┛" ""   ""   ""
        " •" " □" " ☆" " ○" " ■" " ★" " ◎"
        " ●" " △" " ●" " ○" " □" " ●" "≪ ↑ ↓ "))

(standard-display-ascii ?\227 " — ")

(provide 'w3m-conf)
