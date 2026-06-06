{ ... }:
{
  flake.homeManagerModules.emacs =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        pyright
        rust-analyzer
        nil
        zls
        zig-zlint
      ];

      programs.emacs = {
        enable = true;
        extraConfig = builtins.readFile ./init.el;
        extraPackages =
          epkgs: with epkgs; [
            evil
            evil-collection
            treemacs
            treemacs-evil
            all-the-icons
            corfu
            cape
            orderless
            marginalia
            consult
            vertico
            zig-mode
          ];
      };
    };
}
