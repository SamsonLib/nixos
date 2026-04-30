{ self, inputs, ... }:
{
  flake.nixosModules.rofi =
    { pkgs, lib, ... }:
    {
      programs.rofi.enable = true;
    };
}
