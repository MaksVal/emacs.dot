;(require 'tfsmacs)
(require 'tablist)

(use-package tfsmacs
 ;; :requires (tablist)
  :config
  (setq tfsmacs-cmd  "/opt/tee-clc-14.134.0/tf")
  (setq tfsmacs-login "Gordeev.Maksim,^4aD1YP^YW")
  (setq tfsmacs-current-workspace "infotecs")
  )

(provide 'ide-tfs)
