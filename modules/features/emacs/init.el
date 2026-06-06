;;; init.el --- Modern Emacs config -*- lexical-binding: t; -*-

;; --------------------------------------------------------
;; Package system
;; --------------------------------------------------------
(require 'package)
(setq package-enable-at-startup nil)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; --------------------------------------------------------
;; General UI / behavior
;; --------------------------------------------------------
(setq inhibit-startup-message t)
(setq ring-bell-function 'ignore)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

(setq scroll-margin 7
      scroll-step 1)

(global-display-line-numbers-mode 1)
(column-number-mode 1)

;; --------------------------------------------------------
;; Theme
;; --------------------------------------------------------
(load-theme 'base16-one-light t)

;; --------------------------------------------------------
;; Evil (Vim)
;; --------------------------------------------------------
(setq evil-want-keybinding nil)

(use-package evil
  :init
  (setq evil-want-integration t)
  :config
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

;; --------------------------------------------------------
;; Which Key
;; --------------------------------------------------------
(use-package which-key
  :init
  (which-key-mode))

;; --------------------------------------------------------
;; Treemacs
;; --------------------------------------------------------
(use-package treemacs
  :bind ([f8] . treemacs)
  :config
  (setq treemacs-follow-mode t
        treemacs-filewatch-mode t))

(use-package treemacs-evil)

;; --------------------------------------------------------
;; Completion system (Corfu stack)
;; --------------------------------------------------------
(use-package corfu
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.0)
  (corfu-cycle t))

(use-package corfu-popupinfo
  :after corfu
  :hook (corfu-mode . corfu-popupinfo-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil))

(use-package vertico
  :init
  (vertico-mode))

(use-package marginalia
  :init
  (marginalia-mode))

(use-package consult
  :bind (("C-s" . consult-line)
         ("C-x b" . consult-buffer)
         ("M-y" . consult-yank-pop)))

(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-keyword))

;; --------------------------------------------------------
;; Project management
;; --------------------------------------------------------
(use-package project
  :ensure nil
  :bind (("C-c p f" . project-find-file)
         ("C-c p p" . project-switch-project)))

;; --------------------------------------------------------
;; Tree-sitter (MODERN SYNTAX HIGHLIGHTING)
;; --------------------------------------------------------
(use-package treesit
  :ensure nil
  :config
  (setq treesit-language-source-alist
        '((bash . ("https://github.com/tree-sitter/tree-sitter-bash"))
          (c . ("https://github.com/tree-sitter/tree-sitter-c"))
          (cpp . ("https://github.com/tree-sitter/tree-sitter-cpp"))
          (css . ("https://github.com/tree-sitter/tree-sitter-css"))
          (go . ("https://github.com/tree-sitter/tree-sitter-go"))
          (html . ("https://github.com/tree-sitter/tree-sitter-html"))
          (javascript . ("https://github.com/tree-sitter/tree-sitter-javascript"))
          (json . ("https://github.com/tree-sitter/tree-sitter-json"))
          (python . ("https://github.com/tree-sitter/tree-sitter-python"))
          (rust . ("https://github.com/tree-sitter/tree-sitter-rust"))
          (toml . ("https://github.com/tree-sitter/tree-sitter-toml"))
          (tsx . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src"))
          (typescript . ("https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src"))
          (yaml . ("https://github.com/tree-sitter/tree-sitter-yaml"))
          (nix . ("https://github.com/cstrahan/tree-sitter-nix"))))

  ;; Auto use tree-sitter modes when available
  (dolist (mapping
           '((python-mode . python-ts-mode)
             (js-mode . js-ts-mode)
             (typescript-mode . typescript-ts-mode)
             (rust-mode . rust-ts-mode)
             (go-mode . go-ts-mode)
             (json-mode . json-ts-mode)
             (css-mode . css-ts-mode)
             (bash-mode . bash-ts-mode)))
    (add-to-list 'major-mode-remap-alist mapping)))

;; --------------------------------------------------------
;; Language servers (Eglot)
;; --------------------------------------------------------
(use-package eglot
  :ensure nil
  :config
  (setq eglot-autoshutdown t
        eglot-connect-timeout 30))

;; Auto-enable LSP
(dolist (hook '(python-mode-hook
                python-ts-mode-hook
                js-mode-hook
                js-ts-mode-hook
                typescript-mode-hook
                typescript-ts-mode-hook
                rust-mode-hook
                rust-ts-mode-hook
                go-mode-hook
                go-ts-mode-hook
                nix-mode-hook
                nix-ts-mode-hook))
  (add-hook hook #'eglot-ensure))

;; Nix LSP
(add-to-list 'eglot-server-programs
             '(nix-mode . ("nixd")))
(add-to-list 'eglot-server-programs
             '(nix-ts-mode . ("nixd")))

;; --------------------------------------------------------
;; Languages
;; --------------------------------------------------------
(use-package nix-mode
  :mode "\\.nix\\'")

(use-package web-mode
  :mode ("\\.html?\\'" "\\.tsx\\'" "\\.jsx\\'")
  :config
  (setq web-mode-enable-auto-closing t))

(use-package yaml-mode
  :mode "\\.ya?ml\\'")

(use-package dockerfile-mode
  :mode "Dockerfile\\'")

;; --------------------------------------------------------
;; Formatting (Apheleia)
;; --------------------------------------------------------
(use-package apheleia
  :config
  (apheleia-global-mode +1)

  (setf (alist-get 'nix-mode apheleia-mode-alist) 'nixfmt)
  (setf (alist-get 'python-mode apheleia-mode-alist) 'black)
  (setf (alist-get 'python-ts-mode apheleia-mode-alist) 'black)
  (setf (alist-get 'js-mode apheleia-mode-alist) 'prettier)
  (setf (alist-get 'typescript-mode apheleia-mode-alist) 'prettier)
  (setf (alist-get 'web-mode apheleia-mode-alist) 'prettier))

;; --------------------------------------------------------
;; Key quality-of-life tweaks
;; --------------------------------------------------------
(setq tab-always-indent 'complete
      completion-cycle-threshold 3)

(global-set-key (kbd "C-c p p") 'completion-at-point)

;; --------------------------------------------------------
;; EOF
;; --------------------------------------------------------
