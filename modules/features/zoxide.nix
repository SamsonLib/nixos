{ ... }:
{
  flake.nixosModules.zoxide =
    { ... }:
    {
      programs.zoxide = {
        enableFishIntegration = true;
        enable = true;
      };
    };
}
