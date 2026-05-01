{ ... }:
{
  flake.homeManagerModules.zed =
    { pkgs, ... }:
    {
      # https://github.com/zed-industries/extensions/tree/main/extensions
      programs.zed-editor = {
        enable = true;
        extraPackages = [
          pkgs.nixd
          pkgs.nil
        ];

        extensions = [
          "nix"
        ];
      };
    };
}
