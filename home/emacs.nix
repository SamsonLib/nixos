{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;

    extraPackages = epkgs: with epkgs; [
      use-package

      magit

      evil
      evil-collection

      lsp-mode
      lsp-ui
      lsp-treemacs
      dap-mode

      corfu
      cape
      orderless

      consult
      embark
      which-key

      yasnippet
      yasnippet-snippets
    ] ++ [ pkgs.python313Packages.python-lsp-server ];

    extraConfig = ''
      ;; Basic UI
      (setq inhibit-startup-screen t)
      (menu-bar-mode -1)
      (tool-bar-mode -1)
      (scroll-bar-mode -1)

      
      (setq package-enable-at-startup nil)

      ;; Completion framework
      (setq completion-styles '(orderless basic)
            completion-category-defaults nil
            completion-category-overrides '((file (styles partial-completion))))

      (use-package corfu
        :init
        (global-corfu-mode)
        :custom
        (corfu-auto t)
        (corfu-cycle t)
        (corfu-preselect 'prompt))

      (use-package cape
        :init
        (add-to-list 'completion-at-point-functions #'cape-file)
        (add-to-list 'completion-at-point-functions #'cape-dabbrev)
        (add-to-list 'completion-at-point-functions #'cape-keyword))

      ;; LSP
      (use-package lsp-mode
        :commands lsp
        :hook ((c-mode c++-mode python-mode rust-mode nix-mode) . lsp)
        :custom
        (lsp-completion-provider :none)
        (lsp-enable-snippet t)
        (lsp-headerline-breadcrumb-enable t)
        (lsp-idle-delay 0.5))

      (use-package lsp-ui
        :after lsp-mode
        :custom
        (lsp-ui-doc-enable t)
        (lsp-ui-sideline-enable t))

      ;; Diagnostics (built-in)
      (setq flymake-no-changes-timeout nil)

      ;; Snippets
      (use-package yasnippet
        :init
        (yas-global-mode 1))

      ;; Discoverability
      (use-package which-key
        :init
        (which-key-mode 1))

      ;; Search / actions
      (use-package consult)
      (use-package embark
        :bind (("C-." . embark-act)))

      ;; Lisp evaluation
      (global-set-key (kbd "C-x C-e") #'eval-last-sexp)
      (global-set-key (kbd "C-M-x") #'eval-defun)

      (setq enable-local-variables :all)
      (setq enable-local-eval t)

      ;; Evil setup
      (use-package evil
       :init
        (setq evil-want-integration t
              evil-want-keybinding nil
              evil-want-C-u-scroll t
              evil-want-C-i-jump nil)
        :config
        (evil-mode 1))


      (use-package evil-collection
        :after evil
        :config
        (evil-collection-init))

    '';
  };
}

