{ ... }:
{
  flake.homeManagerModules.emacs =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        pyright
        rust-analyzer
        nil
      ];

      programs.emacs = {
        enable = true;
        extraConfig = ''
          ;; Speed up initial startup
          (setq
           gc-cons-threshold 402653184
           gc-cons-percentage 0.6)
          (setq inhibit-startup-message t)
          (setq-default
           indent-tabs-mode nil
           bidi-display-reordering nil
           cursor-in-non-selected-windows nil
           )
          (setq
           max-specpdl-size 5000
           shell-file-name "/run/current-system/sw/bin/bash"
           make-backup-files nil
           auto-save-default nil
           initial-major-mode 'eshell-mode
           initial-scratch-message nil
           completion-at-point-functions nil
           user-full-name "Samson"
           custom-file "/dev/null"
           recentf-max-saved-items nil
           recentf-keep '(recentf-keep-default-predicate remote-file-p)
           x-wait-for-event-timeout nil
           confirm-kill-emacs 'y-or-n-p
           disabled-command-function nil
           password-cache t
           password-cache-expiry 3600
           visible-cursor nil
           scroll-step 1
           focus-follows-mouse nil
           sentence-end-double-space nil
           )
          (menu-bar-mode -1)
          (tool-bar-mode -1)
          (scroll-bar-mode -1)
          (blink-cursor-mode -1)
          (show-paren-mode -1)
          (tooltip-mode -1)
          (global-hl-line-mode)
          (column-number-mode)
          (recentf-mode)
          (server-start)

          ;; ── Evil ────────────────────────────────────────────────────────────
          (setq evil-want-integration t
                evil-want-keybinding nil   ; required before evil-collection
                evil-want-C-u-scroll t
                evil-undo-system 'undo-redo)
          (require 'evil)
          (evil-mode 1)

          (require 'evil-collection)
          (evil-collection-init)

          ;; ── Magit ───────────────────────────────────────────────────────────
          (require 'magit)
          (global-set-key (kbd "C-c g") #'magit-status)

          ;; ── Vertico (minibuffer completion UI) ──────────────────────────────
          (require 'vertico)
          (vertico-mode 1)
          (setq vertico-cycle t)

          ;; ── Orderless (fuzzy/space-separated completion style) ───────────────
          (require 'orderless)
          (setq completion-styles '(orderless basic)
                completion-category-overrides '((file (styles basic partial-completion))))

          ;; ── Consult (enhanced search & navigation commands) ──────────────────
          (require 'consult)
          (global-set-key (kbd "C-s")     #'consult-line)
          (global-set-key (kbd "C-x b")   #'consult-buffer)
          (global-set-key (kbd "C-x C-r") #'consult-recent-file)
          (global-set-key (kbd "M-g g")   #'consult-goto-line)
          (global-set-key (kbd "M-s r")   #'consult-ripgrep)

          ;; ── Embark (context actions on minibuffer candidates) ────────────────
          (require 'embark)
          (require 'embark-consult)
          (global-set-key (kbd "C-.") #'embark-act)
          (global-set-key (kbd "C-;") #'embark-dwim)
          (global-set-key (kbd "C-h B") #'embark-bindings)
          (add-hook 'embark-collect-mode-hook #'consult-preview-at-point-mode)

          ;; ── Marginalia (annotations in minibuffer) ───────────────────────────
          ;; pairs well with vertico+consult
          (require 'marginalia)
          (marginalia-mode 1)

          ;; ── Company (in-buffer completion) ───────────────────────────────────
          (require 'company)
          (setq company-idle-delay 0.2
                company-minimum-prefix-length 2
                company-tooltip-align-annotations t
                company-selection-wrap-around t)
          (global-company-mode 1)

          ;; ── LSP Mode ─────────────────────────────────────────────────────────
          (require 'lsp-mode)
          (setq lsp-keymap-prefix "C-c l"
                lsp-idle-delay 0.5
                lsp-log-io nil               ; set t to debug
                lsp-completion-provider :company-capf
                lsp-headerline-breadcrumb-enable nil)
          ;; Hook into common languages — add/remove as needed
          (add-hook 'python-mode-hook    #'lsp-deferred)
          (add-hook 'js-mode-hook        #'lsp-deferred)
          (add-hook 'typescript-mode-hook #'lsp-deferred)
          (add-hook 'rust-mode-hook      #'lsp-deferred)
          (add-hook 'go-mode-hook        #'lsp-deferred)
          (add-hook 'c-mode-hook         #'lsp-deferred)
          (add-hook 'c++-mode-hook       #'lsp-deferred)
          (add-hook 'nix-mode-hook       #'lsp-deferred)

          (require 'lsp-julia)
          (require 'julia-mode)

          ;; lsp-ui (hover docs, sideline hints)
          (require 'lsp-ui)
          (setq lsp-ui-doc-enable t
                lsp-ui-doc-position 'at-point
                lsp-ui-sideline-enable t
                lsp-ui-sideline-show-diagnostics t
                lsp-ui-sideline-show-hover nil)

          ;; ── Wind down ────────────────────────────────────────────────────────
          (setq
           gc-cons-threshold 16777216
           gc-cons-percentage 0.1)
          (provide 'init)
        '';
        extraPackages =
          epkgs: with epkgs; [
            # evil
            evil
            evil-collection

            # git
            magit

            # minibuffer / completion
            vertico
            orderless
            consult
            embark
            embark-consult
            marginalia
            julia-mode
            lsp-julia
            # in-buffer completion
            company

            # lsp
            lsp-mode
            lsp-ui
          ];
      };
    };
}
