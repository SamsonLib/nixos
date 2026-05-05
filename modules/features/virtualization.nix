{ ... }:
{
  flake.nixosModules.virtualization =
    { ... }:
    {
      programs.virt-manager.enable = true;
      users.groups.libvirtd.members = [ "samson" ];
      virtualisation.libvirtd.enable = true;
      virtualisation.spiceUSBRedirection.enable = true;

      dconf.settings = {
        "org/virt-manager/virt-manager/connections" = {
          autoconnect = [ "qemu:///system" ];
          uris = [ "qemu:///system" ];
        };
      };

      users.users.samson.extraGroups = [ "libvirtd" ];
    };
}
