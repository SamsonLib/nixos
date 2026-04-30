{ self, inputs, ... }:
{
  flake.nixosModules.stylix =
    { pkgs, lib, ... }:
    {
      modules = [
        inputs.stylix.nixosModules.stylix
      ];

      programs.stylix = {
        enable = true;
      };
    };
}
