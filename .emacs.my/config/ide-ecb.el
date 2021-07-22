(add-to-list 'load-path "~/.emacs.d/exteranl/ecb")

(require 'ecb)
;; (require 'ecb-autoloads)
(setq ecb-version-check nil)
(setq-default ecb-tip-of-the-day nil)
(setq stack-trace-on-error t)
(setq ecb-layout-name "top6")

;; By default, ECB hides the compilation window. Show all
;; (setq ecb-show-sources-in-directories-buffer 'always)

;; (setq ecb-compile-window-height 12)

;;; replacement for built-in ecb-deactive, ecb-hide-ecb-windows and
;;; ecb-show-ecb-windows functions
;;; since they hide/deactive ecb but not restore the old windows for me
;; (defun tmtxt/ecb-deactivate ()
;;   "deactive ecb and then split emacs into 2 windows that contain 2 most recent buffers"
;;   (interactive)
;;   (ecb-deactivate)
;;  (split-window-right)
;;  (switch-to-next-buffer)
;;  (other-window 1))
(defun tmtxt/ecb-hide-ecb-windows ()
  "hide ecb and then split emacs into 2 windows that contain 2 most recent buffers"
  (interactive)
  (ecb-hide-ecb-windows)
;;  (split-window-right)
;;  (switch-to-next-buffer)
  (other-window 1))
(defun tmtxt/ecb-show-ecb-windows ()
  "show ecb windows and then delete all other windows except the current one"
  (interactive)
  (ecb-show-ecb-windows)
  (delete-other-windows))


;;; activate and deactivate ecb
(global-set-key (kbd "C-x C-;") 'ecb-activate)
(global-set-key (kbd "C-x C-'") 'tmtxt/ecb-deactivate)
;;(global-set-key (kbd "C-x C-'") 'ecb-deactivate)

;;; show/hide ecb window
;; (global-set-key (kbd "C-;") 'ecb-show-ecb-windows)
;; (global-set-key (kbd "C-'") 'ecb-hide-ecb-windows)
(global-set-key (kbd "C-;") 'tmtxt/ecb-show-ecb-windows)
(global-set-key (kbd "C-'") 'tmtxt/ecb-hide-ecb-windows)

;;; quick navigation between ecb windows
(global-set-key (kbd "C-)") 'ecb-goto-window-edit1)
(global-set-key (kbd "C-!") 'ecb-goto-window-directories)
(global-set-key (kbd "C-@") 'ecb-goto-window-sources)
(global-set-key (kbd "C-#") 'ecb-goto-window-methods)
(global-set-key (kbd "C-$") 'ecb-goto-window-compilation)

(provide 'ide-ecb)
