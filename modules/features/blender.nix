{ ... }:
{
  flake.homeManagerModules.blender =
    { pkgs, ... }:
    {
      home.packages = [
        (pkgs.blender.override {
          cudaSupport = true;
        })
      ];
    };
}
