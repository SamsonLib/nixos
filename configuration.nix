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

  stylix = {
    enable = true;
    image = pkgs.fetchurl {
      url = "https://i.redd.it/65m51o8v3cm61.png";
      hash = "sha256-ZD4Hb3Ugn7b3lSFQSQKUrlQ0Y9GKhPeyoJ6t7xqkQVg=";
    };
    polarity = "dark";
    cursor = {
      package = mcmojave-hyprcursor.packages.${pkgs.system}.default;
      size = 24;
      name = "McMojave";
    };
  };

  networking.hostName = "aurelius";
  networking.networkmanager.enable = true;

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
    extraGroups = [ "wheel" "networkmanager" "video" "input" ]; # Enable ‘sudo’ for the user.
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

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
    vim
    git
    wget
    mcmojave-hyprcursor.packages.${pkgs.system}.default

  ];
 
  security.sudo.wheelNeedsPassword = false;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11"; # Did you read the comment?
}

