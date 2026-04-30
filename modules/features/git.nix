{ self, inputs, ... }:
{
  flake.nixosModules.git =
    { pkgs, lib, ... }:
    {
      programs.git = {
        enable = true;
        settings = {
          user.name = "Samson Liebscher";
          user.email = "samson.gw21@gmail.com";
          safe.directory = "/etc/nixos/";
        };
      };
    };
}
