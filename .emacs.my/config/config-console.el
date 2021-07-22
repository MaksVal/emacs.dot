(require 'ansi-color)
(require 'eshell)

;; (add-hook 'emacs-startup-hook (lambda ()
;;                                 (let ((default-directory (getenv "HOME")))
;;                                   (command-execute 'eshell)
;;                                   (bury-buffer))))

;; (defun eshell-handle-ansi-color ()
;;   (ansi-color-apply-on-region eshell-last-output-start
;;                               eshell-last-output-end))
;; (add-to-list 'eshell-output-filter-functions 'eshell-handle-ansi-color)

;; (add-hook 'eshell-preoutput-filter-functions  'ansi-color-apply)

;; (setq eshell-prompt-function (lambda nil
;;                                (concat
;;                                 (propertize (eshell/pwd) 'face `(:foreground "blue"))
;;                                 (propertize " $ " 'face `(:foreground "green")))))
;; (setq eshell-highlight-prompt nil)

(provide 'config-console)
