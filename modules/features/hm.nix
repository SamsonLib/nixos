{ self, inputs, ... }:
{
  flake.nixosModules.hm =
    { pkgs, lib, ... }:
    {
      #imports = [
      #  inputs.home-manager.nixosModules.home-manager
      #];

    };
}
