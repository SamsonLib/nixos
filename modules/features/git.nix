{ self, inputs, ... }:
{
  flake.nixosModules.git =
    { pkgs, lib, ... }:
    {
      programs.git = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.myGit;
        config = {
          #"user.name" = "Samson Liebscher";
          #"user.email" = "samson.gw21@gmail.com";
          # "safe.directory" = "/etc/nixos/";
        };
      };
    };
  perSystem =
    { pkgs, lib, ... }:
    {
      packages.myGit = inputs.wrapper-modules.wrappers.git.wrap {
        inherit pkgs;
        settings = {
          user = {
            name = "Samson Liebscher";
            email = "samson.gw21@gmail.com";
          };
          safe.directory = "/etc/nixos/";
        };
      };
    };
}
