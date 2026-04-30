{ self, inputs, ... }:
{
  flake.nixosModules.zed =
    { pkgs, lib, ... }:
    {
      programs.zed-editor = {
        enable = true;
      };
    };
}
