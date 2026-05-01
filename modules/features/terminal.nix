{ ... }:
{
  flake.homeManagerModules.terminal =
    { self, ... }:
    {
      imports = [
        self.homeManagerModules.kitty
        self.homeManagerModules.bash
        self.homeManagerModules.fish
      ];
    };
}
