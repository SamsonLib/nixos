{ ... }:
{
  flake.homeManagerModules.krita =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.krita
      ];
    };
}
