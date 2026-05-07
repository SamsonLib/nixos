{ ... }:
{
  flake.nixosModules.virtualization =
    { pkgs, ... }:
    {
      programs.virt-manager.enable = true;
      users.groups.libvirtd.members = [ "samson" ];
      virtualisation.libvirtd.enable = true;
      virtualisation.spiceUSBRedirection.enable = true;

      environment.systemPackages = [
        pkgs.edk2
        pkgs.OVMF
        pkgs.qemu
        pkgs.quickemu
      ];

      # networking.firewall.trustedInterfaces = [ "virbr0" ];

      home-manager.users.samson =
        { ... }:
        {
          dconf.settings = {
            "org/virt-manager/virt-manager/connections" = {
              autoconnect = [ "qemu:///system" ];
              uris = [ "qemu:///system" ];
            };
          };
        };

      users.users.samson.extraGroups = [ "libvirtd" ];
    };
}
