{ ... }:
{
  flake.homeManagerModules.emacs =
    { pkgs, ... }:
    {
      services.emacs = {
        enable = true;
        client.enable = true;
        defaultEditor = true;
      };

      programs.emacs = {
        enable = true;
        extraConfig = ''
          ;; Speed up initial startup
          (setq
           gc-cons-threshold 402653184
           gc-cons-percentage 0.6)
          (setq inhibit-startup-message t)  ; Don't show the splash screen
          (setq-default
           indent-tabs-mode nil ;; Default to indenting with spaces
           bidi-display-reordering nil
           cursor-in-non-selected-windows nil
           )
           ;; Set non-package-specific global variables
           (setq
            max-specpdl-size 5000
            shell-file-name "/run/current-system/sw/bin/bash" ;; Full path to shell (NixOS)
            make-backup-files nil ;; Don't pullute folders with backups
            auto-save-default nil ;; Don't auto-save
            initial-major-mode 'eshell-mode ;; Start the *scratch* buffer in eshell-mode
            initial-scratch-message nil ;; Don't print a bunch of text in *scratch*
            completion-at-point-functions nil
            user-full-name "Samson" ;; My full name
            custom-file "/dev/null" ;; Don't save customizations, just delete them
            recentf-max-saved-items nil ;; Save the entire recent files list
            recentf-keep '(recentf-keep-default-predicate remote-file-p) ;; Exclude remote files from the recent files list
            x-wait-for-event-timeout nil
            confirm-kill-emacs 'y-or-n-p ;; Ask before exiting Emacs
            disabled-command-function nil
            password-cache t ;; Cache passwords
            password-cache-expiry 3600 ;; Expire after one hour
            inhibit-startup-message t
            visible-cursor nil ;; Reduce cursor annoyance
            scroll-step 1 ;; Don't jump around so much while scrolling
            focus-follows-mouse nil ;; Prevent lsp-ui from stealing mouse focus
            sentence-end-double-space nil ;; Don't whine about spaces after periods
            )

           (menu-bar-mode -1) ;; Don't display menu bar
           (tool-bar-mode -1) ;; Don't display tool bar
           (scroll-bar-mode -1) ;; Don't display scroll bar
           (blink-cursor-mode -1) ;; Don't blink the cursor
           (show-paren-mode -1) ;; Don't highlight parentheses
           (tooltip-mode -1) ;; Don't display tooltips as popups, use the echo area instead
           (global-hl-line-mode) ;; Highlight the current line in all buffers

           (column-number-mode) ;; Display column number in the mode line
           (recentf-mode) ;; Enable recording recently-visited files
        '';
        extraPackages = with pkgs.emacsPackages; [
          evil
        ];
      };
    };
}
