{ self, inputs, ... }:
{
  flake.nixosModules.zed =
    { pkgs, lib, ... }:
    {
      environment.systemPackages = [
        pkgs.zed-editor
      ];
    };

  # perSystem =
  #   { pkgs, lib, ... }:
  #   {
  #     packages.myKitty = inputs.wrapper-modules.wrappers.kitty.wrap { inherit pkgs; };
  #   };
}
