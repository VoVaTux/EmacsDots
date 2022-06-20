(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)

(menu-bar-mode -1)
(setq visible-bell 1)

(load-theme 'nord t)
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa/")
			 ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(nord-theme desktop-environment projectile exwm all-the-icons org-mode evil-colemak-basics dracula-theme dashboard doom-modeline counsel use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(use-package ivy
  :diminish
  :bind (("C-s" . swiper))
  )
(ivy-mode 1)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)


(use-package dashboard
  :init      ;; tweak dashboard config before loading it
  (setq dashboard-set-heading-icons t)
  (setq dashboard-banner-logo-title "There is no system but Emacs, Gnu/Linux is one of it's variants")
  ;;(setq dashboard-startup-banner 'logo) ;; use standard emacs logo as banner
  (setq dashboard-startup-banner "~/Downloads/emacs.png")  ;; use custom image as banner
  (setq dashboard-center-content nil) ;; set to 't' for centered content
  (setq dashboard-items '((recents . 5)
                          (agenda . 5 )
                          (bookmarks . 3)
                          (projects . 3)
                          (registers . 3)))
  :config
  (dashboard-setup-startup-hook)
  (dashboard-modify-heading-icons '((recents . "file-text")
			      (bookmarks . "book"))))

(require 'evil)
(evil-mode 1)

(define-key evil-normal-state-map "i" nil)
(define-key evil-normal-state-map "u" 'evil-insert)
(define-key evil-motion-state-map "h" 'evil-backward-char)
(define-key evil-motion-state-map "i" 'evil-forward-char)
(define-key evil-motion-state-map "n" 'evil-next-line)
(define-key evil-motion-state-map "e" 'evil-previous-line)
(define-key evil-normal-state-map "l" 'evil-undo)

(use-package org)
(use-package all-the-icons)
(cua-mode t)
(set-frame-parameter nil 'fullscreen 'fullboth)
(use-package projectile)
(use-package exwm
  :config
  (setq exwm-workspaces-number 5)
  (setq exwm-input-prefix-keys
      '(?\C-x
	?\C-u
	?\C-h
	?\M-x
	?\M-&
	?\s-e
	?\s-s
	?\s-n
	?\s-t))

   (setq exwm-input-global-keys
        `(
          ([?\s-r] . exwm-reset)
          ([s-left] . windmove-left)
          ([s-right] . windmove-right)
          ([s-up] . windmove-up)
          ([s-down] . windmove-down)
	  
          ([?\s-&] . (lambda (command)
                       (interactive (list (read-shell-command "$ ")))
                       (start-process-shell-command command nil command)))

          ([?\s-w] . exwm-workspace-switch)
          ([?\s-`] . (lambda () (interactive) (exwm-workspace-switch-create 0)))

          ,@(mapcar (lambda (i)
                      `(,(kbd (format "s-%d" i)) .
                        (lambda ()
                          (interactive)
                          (exwm-workspace-switch-create ,i))))
                    (number-sequence 0 9))))


  (exwm-init))


(use-package desktop-environment
  :after exwm
  :config (desktop-environment-mode))

(global-set-key (kbd "s-e") 'enlarge-window-horizontally)
(global-set-key (kbd "s-s") 'shrink-window-horizontally)
(global-set-key (kbd "s-n") 'other-window)
(global-set-key (kbd "s-t") 'eshell)
