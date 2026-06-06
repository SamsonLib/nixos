{ ... }:
{
  flake.homeManagerModules.nemo =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.nemo-with-extensions.override { })
      ];
    };
}
