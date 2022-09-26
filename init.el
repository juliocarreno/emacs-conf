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
  :ensure t
  :config
  (progn
    (global-set-key (kbd "C-c a") 'org-agenda)
    (setq org-agenda-files (directory-files-recursively "~/org/" "\\.org$"))))

;; (use-package org-indent
;;   :ensure t
;;   :diminish
;;   :custom
;;   (org-indent-indentation-per-level 4))

;; (use-package org-agenda
;;   :ensure t 
;;   :after org
;;   :bind
;;   ("C-c a" . org-agenda)
;;   :custom
;;   (org-agenda-include-diary t)
;;   (org-agenda-prefix-format '((agenda . "%i %-12:c%?-12t% s")
;; 			      ;; Indent todo items by level to show nesting
;; 			      (todo . " %i %-12:c%1")
;; 			      (tags . " %i %-12:c")
;; 			      (search . " %i %-12:c")))
;;   (org-agenda-start-on-weekday nil))


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
  (company-idle-delay 0.2)
  (company-minimum-prefix-length 3)
  (company-selection-wrap-around t)
  (company-require-match 'never)
  (company-show-number t)
  :config
  (global-company-mode t))

(add-to-list 'company-backends #'company-tabnine)

;; Tabnine
(use-package company-tabnine :ensure t)

;; Json Mode
(use-package json-mode
  :ensure t)

;; Dictionary
(use-package dictionary
  :ensure t
  :defer t)

;; Web mode
(use-package web-mode
  :ensure t
  :mode (("\\.js\\'" . web-mode)
	 ("\\.jsx\\'" . web-mode)
	 ("\\.ts\\'" . web-mode)
	 ("\\.html\\'" . web-mode)
	 ("\\.twig\\'" . web-mode))
  :commands web-mode
  :config
  (setq web-mode-attr-indent-offset 4
	web-mode-code-indent-offset 4
	web-mode-css-indent-offset 4
	web-mode-indent-style 4
	web-mode-markup-indent-offset 4
	web-mode-sql-indent-offset 4)
  (setq web-mode-ac-sources-alist
	'(("php" . (ac-source-php-extras
		    ac-source-yasnippet
		    ac-source-gtags
		    ac-source-abbrev
		    ac-source-dictionary
		    ac-source-words-in-same-mode-buffers))
	  ("css" . (ac-source-css-property
		    ac-source-abbrev
		    ac-source-dictionary
		    ac-source-words-in-same-mode-buffers))))
  (add-hook 'web-mode-hook
	    (lambda()
	      (setq web-mode-style-padding 4)
	      (yas-minor-mode t)
	      (emmet-mode)
	      (flycheck-add-mode 'html-tidy 'web-mode)
	      (flycheck-mode)))
  (add-hook 'web-mode-before-auto-complete-hooks
	    '(lambda()
	       (let ((web-mode-cur-language (web-mode-language-at-pos)))
		 (if (string= web-mode-cur-language "php")
		     (yas-activate-extra-mode 'php-mode)
		   (yas-deactivate-extra-mode 'php-mode))
		 (if (string= web-mode-cur-language "css")
		     (setq emmet-use-css-transform t)
		   (setq emmet-use-css-transform nil))))))

;; Flycheck
(use-package flycheck
  :ensure t
  :commands flycheck-mode)

;; Magit - Source control for git
(use-package magit
  :ensure t
  :defer t
  :bind (("C-x g" . magit-status))
  :config
  (setq magit-branch-arguments nil)
  (setq magit-push-always-verify nil)
  (setq magit-last-seen-setup-instructions "1.4.0"))

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

;; Ox reveal
(use-package ox-reveal :ensure t)

;; Org tree slide for presentation
(defun efs/presentation-setup ()
  ;; Hide the mode line
  (hide-mode-line-mode 1)
  ;; Display images inline
  (org-display-inline-images)
  ;; Scale the text
  (setq text-scale-mode-amount 3)
  (text-scale-mode 1))

(defun efs/presentation-end ()
  ;; Show the mode line again
  (hide-mode-line-mode 0))

(use-package org-tree-slide
  :ensure t
  :hook ((org-tree-slide-play . efs/presentation-setup)
	 (org-tree-slide-stop . efs/presentation-end))
  :custom
  (org-image-actual-width nil)
  (org-tree-slide-slide-in-effect nil)
  (org-tree-slide-header t)
  (org-tree-slide-breadcrumbs " // "))

;; Emmet mode
(use-package emmet-mode
  :ensure t
  :commands emmet-mode
  :config
  (add-hook 'emmet-mode-hook
	    (lambda()
	      (evil-define-key 'insert emmet-mode-keymap (kbd "C-S-l") 'emmet-next-edit-point)
	      (evil-define-key 'insert emmet-mode-keymap (kbd "C-S-h") 'emmet-prev-edit-point))))

;; Yaml mode
(use-package yaml
  :ensure t
  ;; .yaml or .yml
  :mode "\\(?:\\(?:\\.y\\(?:a?ml\\)\\)\\)\\'")

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
 '(org-agenda-files (quote ("~/org/work.org")))
 '(package-selected-packages
   (quote
    (org-agenda-property company-tabnine magit dashboard json-mode prettier-js vterm yaml-mode yaml writegood-mode web-mode use-package phpunit phps-mode php-mode org-tree-slide ob-browser markdown-preview-mode lsp-ui lsp-tailwindcss lsp-latex lsp-docker js2-mode ivy-rich helm-projectile gruvbox-theme go-mode flycheck exec-path-from-shell evil-visual-mark-mode dap-mode company cargo-mode auto-complete all-the-icons-ivy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
