{ ... }:
{
  flake.homeManagerModules.direnv =
    { ... }:
    {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
}
