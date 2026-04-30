{ self, inputs, ... }:
{
  flake.nixosModules.homeManager =
    { pkgs, lib, ... }:
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
      ];

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;

      home-manager.users.samson = { ... }: {
        home.username = "samson";
        home.homeDirectory = "/home/samson";

        home.stateVersion = "26.05";
        programs.home-manager.enable = true;
      };
    };
}
