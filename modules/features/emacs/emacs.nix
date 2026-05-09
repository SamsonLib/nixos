{ ... }:
{
  flake.homeManagerModules.emacs =
    { ... }:
    {
      # home.packages = with pkgs; [
      #   pyright
      #   rust-analyzer
      #   nil
      # ];

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
          ];
      };
    };
}
