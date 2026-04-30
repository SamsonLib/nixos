{ self, inputs, ... }:
{
  flake.nixosModules.stylix =
    { pkgs, lib, ... }:
    {
      imports = [
        inputs.stylix.nixosModules.stylix
      ];

      stylix = {
        enable = true;
        image = pkgs.fetchurl { url = "https://w.wallhaven.cc/full/x8/wallhaven-x8eydz.jpg"; hash = "sha256-/QEHUeOFtvkxSN9J9yE+5l7lJgHfgAZhTz+0OHg8m8k="; };
      };
    };
}
