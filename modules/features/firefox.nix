{ ... }:
{
  flake.homeManagerModules.firefox =
    { ... }:
    {
      programs.firefox = {
        enable = true;
      };
    };
}
