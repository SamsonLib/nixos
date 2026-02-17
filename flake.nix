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

    hytale-launcher.url = "github:TNAZEP/HytaleLauncherFlake";

    blender.url = "path:./blender.nix"
  };

  outputs = { nixpkgs, stylix, home-manager, mcmojave-hyprcursor, hytale-launcher, blender, ... }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations.aurelius = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ({ pkgs, ... }: {
          environment.systemPackages = [
	    hytale-launcher.packages.${system}.default
	    blender.packages.${system}.default
          ];
        })
	stylix.nixosModules.stylix
        ./configuration.nix
        home-manager.nixosModules.home-manager {
	  home-manager = {
	    useGlobalPkgs = true;
	    useUserPackages = true;
	    users.samson = import ./home/home.nix;
	  };
        }
      ];
      specialArgs = { inherit mcmojave-hyprcursor; };
    };
  };
}
