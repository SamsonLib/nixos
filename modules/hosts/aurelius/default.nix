{ self, inputs, ... }:
{
  flake.nixosConfigurations.aurelius = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.aureliusConfiguration
    ];
  };
}
