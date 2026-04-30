{ self, inputs, ... }:
{
  flake.nixosModules.zoxide =
    { pkgs, lib, ... }:
    {
      programs.zoxide = {
        enableFishIntegration = true;
        enable = true;
      };
    };
}
