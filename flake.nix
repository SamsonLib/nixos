{
  description = "My Home NixOS-Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:nix-community/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "github:hyprwm/Hyprland";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    hytale-launcher.url = "github:TNAZEP/HytaleLauncherFlake";
  };

  outputs =
    inputs@{ nixpkgs, ... }:
    {
      homeConfigurations.samson = inputs.home-manager.lib.homeManagerConfiguration {
        modules = [
          inputs.stylix.homeModules.stylix
        ];
      };

      nixosConfigurations.aurelius = nixpkgs.lib.nixosSystem {
        modules = [
          inputs.stylix.nixosModules.stylix
          inputs.nixvim.nixosModules.nixvim
          inputs.home-manager.nixosModules.home-manager
          ./configuration.nix

          (
            { pkgs, ... }:
            {
              environment.systemPackages = [
                inputs.hytale-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default
              ];

              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.samson = import ./home/home.nix;
              };
            }
          )
        ];
      };
    };
}
