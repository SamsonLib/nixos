{ ... }:
{
  flake.nixosModules.networking = {
    networking = {
      firewall.enable = false;
      hostName = "aurelius";
      networkmanager.enable = true;
      # networkmanager.dns = "none";

      nameservers = [
        "1.0.0.1"
        "1.1.1.1"
      ];
      firewall.checkReversePath = false;
    };

    time.timeZone = "Europe/Berlin";
    i18n.defaultLocale = "en_US.UTF-8";
  };
}
