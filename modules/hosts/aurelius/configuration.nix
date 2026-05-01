{ self, inputs, ... }:
{
  flake.nixosModules.aureliusConfiguration =
    { pkgs, config, ... }:
    {
      imports = [
        self.nixosModules.aureliusHardware
        self.nixosModules.git
        self.nixosModules.zoxide
        inputs.stylix.nixosModules.stylix
        inputs.home-manager.nixosModules.home-manager
      ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users = {
          samson =
            { ... }:
            {
              imports = [
                self.homeManagerModules.kitty
                self.homeManagerModules.rofi
                self.homeManagerModules.hyprland
                self.homeManagerModules.zed
                self.homeManagerModules.eza
                self.homeManagerModules.obsidian
                self.homeManagerModules.firefox
                self.homeManagerModules.nemo
                self.homeManagerModules.blender
                self.homeManagerModules.prismlauncher
              ];

              home.packages = with pkgs; [
                hyprshot
                chatterino7
              ];

              home.stateVersion = "25.11";
              home.username = "samson";
              programs.home-manager.enable = true;
              home.homeDirectory = "/home/samson";
            };
        };
      };

      environment.systemPackages = [
        pkgs.vim
      ];

      stylix = {
        enable = true;
        image = pkgs.fetchurl {
          url = "https://w.wallhaven.cc/full/po/wallhaven-powqje.jpg";
          hash = "sha256-6whG3D30UjQ40WDbwCxYFtI0fOb81KildTNhAcebYek=";
        };
        polarity = "dark";
      };

      boot.loader = {
        efi.canTouchEfiVariables = true;
        efi.efiSysMountPoint = "/boot";
        grub = {
          efiSupport = true;
          device = "nodev";
        };
      };

      programs.nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 4d --keep 3";
        flake = "/etc/nixos/";
      };

      networking = {
        hostName = "aurelius";
        networkmanager.enable = true;
        nameservers = [
          "1.1.1.1"
          "1.0.0.1"
        ];
        firewall.checkReversePath = false;
      };

      time.timeZone = "Europe/Berlin";
      i18n.defaultLocale = "en_US.UTF-8";

      services.udev = {
        enable = true;

        extraRules = ''
          KERNEL=="uinput", GROUP="wheel"
        '';

        extraHwdb = ''
          evdev:name:sec_e-pen*
            EVDEV_ABS_00=::32767
            EVDEV_ABS_01=::32767
            EVDEV_ABS_18=::4096
        '';
      };

      services = {
        avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };
        printing = {
          enable = true;
          drivers = with pkgs; [
            cups-filters
            cups-browsed
          ];
        };
      };

      services.pipewire = {
        enable = true;
        pulse.enable = true;
      };

      services.hardware.openrgb = {
        enable = true;
        package = pkgs.openrgb-with-all-plugins;
      };

      security.sudo.wheelNeedsPassword = false;

      services.getty.autologinUser = "samson";
      services.xserver = {
        videoDrivers = [ "nvidia" ];
        xkb.variant = "dvp";
        xkb.layout = "us";
      };

      console.useXkbConfig = true;

      users.users.samson = {
        isNormalUser = true;
        extraGroups = [
          "wheel"
          "networkmanager"
          "video"
          "input"
          "plugdev"
        ];
      };

      programs.hyprland = {
        enable = true;
        xwayland.enable = true;
      };

      xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-wlr
        ];
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

      fonts.packages = [
        pkgs.nerd-fonts.lilex
      ];

      programs.steam = {
        enable = true;
        protontricks.enable = true;
      };

      programs.nix-ld.enable = true;
      nixpkgs.config.allowUnfree = true;
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      system.stateVersion = "25.11";
    };
}
