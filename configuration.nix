{ inputs, config, lib, pkgs, mcmojave-hyprcursor, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    efi.efiSysMountPoint = "/boot";
    grub = {
      efiSupport = true;
      device = "nodev";
    };
  };

  fonts.packages = [
    pkgs.nerd-fonts.lilex
  ];

  services.flatpak.enable = true;

  services.udev.enable = true;
  services.udev.extraRules = ''
    KERNEL=="uinput", GROUP="wheel"
  '';

  services.udev.extraHwdb = ''
    evdev:name:sec_e-pen*
      EVDEV_ABS_00=::32767
      EVDEV_ABS_01=::32767
      EVDEV_ABS_18=::4096
  '';

  stylix = {
    enable = true;
    # Greek Head
    # image = pkgs.fetchurl { url = "https://i.redd.it/65m51o8v3cm61.png"; hash = "sha256-ZD4Hb3Ugn7b3lSFQSQKUrlQ0Y9GKhPeyoJ6t7xqkQVg="; };
    # Tanjiro Water breathing Dragon
    # image = pkgs.fetchurl { url = "https://w.wallhaven.cc/full/zp/wallhaven-zpxymy.png"; hash = "sha256-I+CFU20xC4FNTiTXH7QyzqoL/3II5EQ+mNdeXq6zlQ0="; };
    # Mountain + Hut Green
    # image = pkgs.fetchurl { url = "https://w.wallhaven.cc/full/21/wallhaven-21z18x.jpg"; hash = "sha256-BPyyNtVPlQULKChBRYPKwyiUHKcQvzaH2sbCsx5EZmM="; };
    # sun god nika
    # image = pkgs.fetchurl { url = "https://w.wallhaven.cc/full/9d/wallhaven-9d3l21.png"; hash = "sha256-k3SFZM9vHHzZYOBDjD3S5z433eXO3DnD7vTqAYXOu2c="; };
    # Neon laying
    # image = pkgs.fetchurl { url = "https://w.wallhaven.cc/full/x8/wallhaven-x8eydz.jpg"; hash = "sha256-/QEHUeOFtvkxSN9J9yE+5l7lJgHfgAZhTz+0OHg8m8k="; };
    # red, samurei
    # image = pkgs.fetchurl { url = "https://w.wallhaven.cc/full/z8/wallhaven-z8p9rj.jpg"; hash = "sha256-qrJAqL+gwiwaSuLN8erApwu11OXIjVJ+ofYeo6GTY90="; };
    # green swamp
    # image = pkgs.fetchurl { url = "https://w.wallhaven.cc/full/ex/wallhaven-exjy6w.jpg"; hash = "sha256-cSHLAbn8ahr3gMxivn4cv5UWVIds6v4HplMzo1psEXc="; };
    # Castle orange green
    # image = pkgs.fetchurl { url = "https://w.wallhaven.cc/full/k8/wallhaven-k89d66.jpg"; hash = "sha256-wVLM0AAy/rCqmUlfOdPTD4UxGrE+20knT/8pO82M4mI="; };
    # Black (Red) Gray Monochrome
    # image = pkgs.fetchurl { url = "https://w.wallhaven.cc/full/k8/wallhaven-k8w5gd.png"; hash = "sha256-xRhXD65t/wUGPDIACdo8sUZUzT0wMyK0zB73SIOdsx8="; };
    # Orb Blue
    # image = pkgs.fetchurl { url = "https://w.wallhaven.cc/full/zy/wallhaven-zy1j3y.jpg"; hash = "sha256-BAVE61Ouo7pZSVULbp/FBZTjxihh08ps7fAyWF3DOZM="; };
    # city orange red
    # image = pkgs.fetchurl { url = "https://w.wallhaven.cc/full/7p/wallhaven-7pd3l9.jpg"; hash = "sha256-LFek+KkQ9Ig6HZrhfyuaP2K3biKW35Wjdsk7DZs0YNA="; };
    # dragen + mountain blue
    # image = pkgs.fetchurl { url = "https://w.wallhaven.cc/full/ml/wallhaven-mlp5q1.jpg"; hash = "sha256-N8uWw0sASc8rudn5Sqt0Y4LoRYRTSjzvOuQdoO12nIE="; };
    # Orange Brown mountain
    # image = pkgs.fetchurl { url = "https://w.wallhaven.cc/full/je/wallhaven-je8me5.png"; hash = "sha256-k1Bct2ZaFdJlaRbRQWCWgSEvXfXyZ7uymEjxfCuSfVs="; };
    # Blue classic art
    # image = pkgs.fetchurl { url = "https://w.wallhaven.cc/full/rq/wallhaven-rq3dmq.jpg"; hash = "sha256-04n7MBXKe+mvX+jqW7wvw+qTKZ/aMrj8Ibj4vrWcHQc="; };
    # Hollow Knight
    # image = pkgs.fetchurl { url = "https://w.wallhaven.cc/full/6d/wallhaven-6dvkpl.jpg"; hash = "sha256-/MB3qXhfagu0CV7uIIMOZM0Piem4tXoWFgaIkBozEpE="; };
    # Gameboy Green Darkred
    # image = pkgs.fetchurl { url = "https://w.wallhaven.cc/full/je/wallhaven-jexerw.png"; hash = "sha256-B5xetPTgFoKQrtEVqOw6rFApPhosa24uOGkFySxvxUA="; };
    # Shore Blue green
    # image = pkgs.fetchurl { url = "https://w.wallhaven.cc/full/vq/wallhaven-vq7k2p.png"; hash = "sha256-9i7NbITPUi5A2dQAGdYzwwNpTybg0Y8nua+Hn1G14wM="; };
    # Purple City
    # image = pkgs.fetchurl { url = "https://w.wallhaven.cc/full/21/wallhaven-21yd3m.jpg"; hash = "sha256-0iBzzfo5JbOK5k4SfqZ9afjFDsJE1RC1Sai1ItiaKBk="; };
    # Cliff blue green
    # image = pkgs.fetchurl { url = "https://w.wallhaven.cc/full/6l/wallhaven-6ljeyx.jpg"; hash = "sha256-Hg5cPfM4DowUFcR6Dypx0OVfZkIG9y+ugcq+T5vt0Cw="; };
    # Tree Colored
    image = pkgs.fetchurl { url = "https://w.wallhaven.cc/full/pk/wallhaven-pkw6y3.jpg"; hash = "sha256-ek0PBDqKeJrDU8/NuXoOhcNbrvMbOibOwPihM2NwIeE="; };
    # Blue Red Magic World
    # image = pkgs.fetchurl { url = "https://w.wallhaven.cc/full/rd/wallhaven-rddgwm.jpg"; hash = ""; };
    # image = pkgs.fetchurl { url = ""; hash = ""; };
    # image = pkgs.fetchurl { url = ""; hash = ""; };
    # image = pkgs.fetchurl { url = ""; hash = ""; };
    # image = pkgs.fetchurl { url = ""; hash = ""; };

    polarity = "dark";
    cursor = {
      package = mcmojave-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default;
      size = 24;
      name = "McMojave";
    };
  };
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/etc/nixos/"; # sets NH_OS_FLAKE variable for you
  };
  networking.hostName = "aurelius";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" "1.0.0.1" ];
  networking.firewall.checkReversePath = false;

  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";

  services.getty.autologinUser = "samson";

  services.xserver = {
    videoDrivers = [ "nvidia" ];
    xkb.variant = "dvp";
    xkb.layout = "us";
  };

  console.useXkbConfig = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users.users.samson = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "input" "plugdev" ]; # Enable ‘sudo’ for the user.
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };


  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  programs.steam.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
    ];
  };

  hardware.opentabletdriver.enable = true;

  hardware = {
    graphics.enable = true;

    nvidia = {
      open = true;
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };

    bluetooth = {
      enable = true;
      powerOnBoot = true;

      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
      };
    };
  };

  

  environment.systemPackages = with pkgs; [
    mcmojave-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default
    vim
    wineWowPackages.stable
    wine
    (wine.override { wineBuild = "wine64"; })
    wine64
    wineWowPackages.staging
    winetricks
    wineWowPackages.waylandFull
    icu
    icu78
    wireguard-tools
    protonvpn-gui
  ];
 
  security.sudo.wheelNeedsPassword = false;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11"; # Did you read the comment?
}

