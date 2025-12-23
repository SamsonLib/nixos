{
  description = "My PC NixOS-Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mcmojave-hyprcursor.url = "github:libadoxon/mcmojave-hyprcursor";
  };

  outputs = { nixpkgs, stylix, home-manager, mcmojave-hyprcursor, ... }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.aurelius = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
	stylix.nixosModules.stylix
        ./configuration.nix
        home-manager.nixosModules.home-manager {
	  home-manager = {
	    useGlobalPkgs = true;
	    useUserPackages = true;
	    users.samson = import ./home.nix;
	  };
        }
      ];
      specialArgs = { inherit mcmojave-hyprcursor; };
    };
  };
}
