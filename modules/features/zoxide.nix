{ ... }:
{
  flake.homeManagerModules.zoxide =
    { ... }:
    {
      programs.zoxide = {
        enableFishIntegration = true;
        enable = true;
      };
    };
}
