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

        userSettings = {
          tab_size = 4;
          hour_format = "hour24";
          load_direnv = "shell_hook";

          inlay_hints = {
            enabled = true;
          };

          diagnostics = {
            inline.enabled = true;
          };
        };
      };
    };
}
