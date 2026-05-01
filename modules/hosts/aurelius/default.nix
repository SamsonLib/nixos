{ self, inputs, ... }:
{
  flake.nixosConfigurations.aurelius = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.aureliusConfiguration
    ];
  };

  flake.homeConfigurations.samson =
    inputs.lib.homeManagerConfiguration {
      modules = [
        #self.homeModules.kitty
      ];
    };
}
