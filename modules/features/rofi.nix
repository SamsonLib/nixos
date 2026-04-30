{ self, inputs, ... }:
{
  flake.homeModules.rofi =
    { pkgs, lib, ... }:
    {
      programs.rofi.enable = true;
    };
}
