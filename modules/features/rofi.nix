{ self, inputs, ... }:
{
  flake.nixosModules.rofi =
    { pkgs, lib, ... }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.myRofi
      ];
    };

  perSystem =
    { pkgs, lib, ... }:
    {
      packages.myRofi = inputs.wrapper-modules.wrappers.rofi.wrap { inherit pkgs; };
    };
}
