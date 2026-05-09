;; Enable MELPA package reposetory ------------------------  -*- lexical-binding: t; -*-
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
;; --------------------------------------------------------

;; Evil mode / Vim keybinds -------------------------------
(setq evil-want-keybinding nil)
(require 'evil)
(evil-mode 1)
(require 'evil-collection)
(evil-collection-init)
;; --------------------------------------------------------

;; Set light colortheme: one-light ------------------------
(load-theme 'base16-one-light t)
;; --------------------------------------------------------

;; Filetree (treemacs) ------------------------------------
(use-package treemacs
  :bind
  ([f8] . treemacs)
  :config
  (treemacs-follow-mode t)
  (treemacs-filewatch-mode t))

(use-package treemacs-evil)
;; --------------------------------------------------------

;; General options ----------------------------------------
(setq ring-bell-function 'ignore)    ; Disable bell sound
(scroll-bar-mode -1)                 ; Disable scrollbar
(setq inhibit-startup-message t)     ;
(setq scroll-margin 7)               ;
(setq scroll-step 1)
;; --------------------------------------------------------

;; Autocomplete -------------------------------------------
;; Enable Corfu globally
(use-package corfu
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)                ;; auto popup suggestions
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.0)
  (corfu-cycle t))              ;; cycle through candidates
(setq corfu-popupinfo-delay 0.2)
(corfu-popupinfo-mode 1)
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))
(use-package cape
  :init
  ;; Add useful global completion sources
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-to-list 'completion-at-point-functions #'cape-abbrev))
(global-set-key (kbd "C-c p p") 'completion-at-point)
(global-set-key (kbd "C-c p d") 'cape-dabbrev)
(use-package marginalia
  :init
  (marginalia-mode))
(use-package vertico
  :init
  (vertico-mode))
(use-package consult
  :bind
  (("C-s" . consult-line)
   ("C-x b" . consult-buffer)
   ("M-y" . consult-yank-pop)))
(setq completion-cycle-threshold 3)
(setq tab-always-indent 'complete)
;; --------------------------------------------------------
