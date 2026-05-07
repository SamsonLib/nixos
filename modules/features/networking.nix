{ ... }:
{
  flake.nixosModules.networking = {
    networking = {
      hostName = "aurelius";
      networkmanager.enable = true;
      networkmanager.dns = "none";

      networkmanager.connectionConfig = {
        "ipv4.ignore-auto-dns" = true;
        "ipv6.ignore-auto-dns" = true;
      };

      nameservers = [ "127.0.0.1" ];
      firewall.checkReversePath = false;
    };

    services.dnsmasq.enable = false;

    services.dnscrypt-proxy = {
      enable = true;
      settings = {
        ipv6_servers = true;
        require_dnssec = true;
        server_names = [ "cloudflare" ];
        listen_addresses = [ "127.0.0.1:53" ];
      };
    };

    time.timeZone = "Europe/Berlin";
    i18n.defaultLocale = "en_US.UTF-8";
  };
}
