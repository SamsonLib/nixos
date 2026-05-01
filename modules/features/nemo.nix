{ ... }:
{
  flake.homeManagerModules.nemo =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.nemo-with-extensions.override {
          extensions = [
            pkgs.nemo-seahorse
            pkgs.nemo-python
            pkgs.nemo-preview
            pkgs.nemo-fileroller
            pkgs.nemo-emblems
          ];
        })
      ];
    };
}
