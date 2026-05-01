{ ... }:
{
  flake.homeManagerModules.eza =
    { ... }:
    {
      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
    };
}
