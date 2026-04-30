{ self, inputs, ... }:
{
  flake.nixosModules.kitty =
    { pkgs, lib, ... }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.myKitty
      ];
    };

  perSystem =
    { pkgs, lib, ... }:
    {
      packages.myKitty = inputs.wrapper-modules.wrappers.kitty.wrap { inherit pkgs; };
    };
}
