(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
	("marmalade" . "http://marmalade-repo.org/packages/")
	("melpa" . "http://melpa.org/packages/")))

(package-initialize)
(require 'package)
(require 'use-package)

(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-s M-o") 'revert-buffer)

;; --------------------------------------------------
;; ------------- Configure --------------------
;; --------------------------------------------------
(windmove-default-keybindings)

;; Evil mode
(use-package evil
  :ensure t
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-flash-delay 0.02)
  :config
  (progn
    (evil-mode 1)
    ;; (evil-define-key 'normal 'global (kbd "<leader>w"))
    ))

;; Org mode
(use-package org
  :ensure t)

;; Gruvbox theme
(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox-dark-hard t))

;; Ido mode
(use-package ido
  :ensure t
  :config
  (ido-mode 1)
  (setq ido-enable-flex-matching t)
  (setq ido-everywhere t))
;; (ido-mode 1)

;; Built in project manager
(use-package project
  :ensure t
  :config
  (global-set-key (kbd "C-c p f") 'project-find-file))

;; LSP Mode
(use-package lsp-mode
  :ensure t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-log-io nil) ;; Don't log everyting = speed
  (setq lsp-restart 'auto-restart)
  (setq lsp-ui-sideline-show-diagnostics t)
  (setq lsp-ui-sideline-show-hover t)
  (setq lsp-ui-sideline-show-code-actions t)
  ;;:hook (;; replace XXX-mode with concrete major-mode (e.g python-mode) (XXX-mode . lsp (python-mode . lsp)
	 ;; if you want which-key integration (lsp-mode . lsp-enable-which-key-integration))
  :hook (
	 (web-mode . lsp-deferred)
	 (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; Optionally
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

(use-package prettier-js
  :ensure t)


;; Projectile
;; (projectile-mode +1)
;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
(use-package projectile
  :ensure t
  :config
  (define-key projectile-mode-map (kbd "C-x p") 'projectile-command-map)
  (projectile-mode +1))

(use-package helm-projectile
  :ensure t
  :config (helm-projectile-on))

;; Company
(use-package company
  :ensure t
  :init
  (add-hook 'after-init-hook 'global-company-mode)
  :custom
  (company-tooltip-limit 5)
  (company-idle-delay 0.0)
  (company-minimum-prefix-length 3)
  (company-selection-wrap-around t)
  (company-require-match 'never)
  :config
  (global-company-mode t))

;; Json Mode
(use-package json-mode
  :ensure t)

;; Web mode
(use-package web-mode
  :ensure t
  :mode (("\\.js\\'" . web-mode)
	 ("\\.jsx\\'" . web-mode)
	 ("\\.ts\\'" . web-mode)
	 ("\\.html\\'" . web-mode))
  :commands web-mode
  :config
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-code-indent-offset 4)
  (setq web-mode-css-indent-offset 4))

;; Magit - Source control for git
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)))

;; Dashboard
(use-package dashboard
  :ensure t
  :init
  (progn
    (setq dashboard-items '((recents . 5)
			    (projects . 5)
			    (agenda . 5)))
    (setq dashboard-show-shortcuts nil)
    (setq dashboard-center-content nil)
    (setq dashboard-banner-logo-title "Hola, IOCARPE")
    (setq dashboard-set-heading-icons t)
    (setq dashboard-set-file-icons t)
    (setq dashboard-startup-banner "~/Images/julio.png")
    (setq dashboard-set-navigator t)
    (setq dashboard-init-info "Welcome, IOCARPE"))
  
  :config
  (dashboard-setup-startup-hook))

;; --------------------------------------------------
;; ------------- Enhancements -----------------------
;; --------------------------------------------------
(scroll-bar-mode 0) ;; Disable visible scroll
(tool-bar-mode 0) ;; Disable the toolbar 
(tooltip-mode -1) ;; Disable tooltips 
(set-fringe-mode 10) ;; Give some breathing room 
(menu-bar-mode -1) ;; Disable the menu bar 
(setq visible-bell 1) ;; Setup visible bell 

;; ------------------ Fonts -------------------------
(set-face-attribute 'default nil :height 130)
(setq line-spacing 0.5)
(setq-default line-spacing 0.5)

;; Faster to quit
(fset 'yes-or-no-p 'y-or-n-p)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Activate line numbers 
(column-number-mode)
(global-display-line-numbers-mode t)

;; Avoid backup files
;; (setq make-backup-files nil)

;; Move backup files to another directoy
(setq backup-directory-alist '((".*" . "~/.Trash")))
(setq create-lockfiles nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (magit dashboard json-mode prettier-js vterm yaml-mode yaml writegood-mode web-mode use-package phpunit phps-mode php-mode org-tree-slide ob-browser markdown-preview-mode lsp-ui lsp-tailwindcss lsp-latex lsp-docker js2-mode ivy-rich helm-projectile gruvbox-theme go-mode flycheck exec-path-from-shell evil-visual-mark-mode dap-mode company cargo-mode auto-complete all-the-icons-ivy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
