{ ... }:
{
  flake.homeManagerModules.nu =
    { pkgs, ... }:
    {

      programs.nushell = {
        enable = true;
        extraConfig = ''

          $env.config = {
              datetime_format: {
                  normal: "%d/%m/%Y %T"
              }
              show_banner: false
              completions: {
                  algorithm: "fuzzy"
              }
          }
        '';
      };
    };
}
