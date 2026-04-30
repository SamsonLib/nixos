{ self, inputs, ... }:
{
  flake.homeModules.kitty =
    { pkgs, lib, ... }:
    {
      programs.kitty.enable = true;
    };
}
