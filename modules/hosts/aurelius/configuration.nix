{ self, inputs, ... }:
{
  flake.nixosModules.aureliusConfiguration =
    { pkgs, config, ... }:
    {
      imports = [
        self.nixosModules.aureliusHardware
        self.nixosModules.git
        self.nixosModules.networking
        # self.nixosModules.virtualization
        inputs.stylix.nixosModules.stylix
        inputs.home-manager.nixosModules.home-manager
      ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        sharedModules = [
          {
            stylix.targets.emacs.enable = true;
          }
        ];
        extraSpecialArgs = { inherit self; };
        users.samson =
          { ... }:
          {
            imports = [
              self.homeManagerModules.bat
              # self.homeManagerModules.blender
              self.homeManagerModules.eza
              self.homeManagerModules.firefox
              self.homeManagerModules.hyprland
              self.homeManagerModules.nemo
              self.homeManagerModules.obsidian
              self.homeManagerModules.prismlauncher
              self.homeManagerModules.rofi
              self.homeManagerModules.terminal
              self.homeManagerModules.zed
              # self.homeManagerModules.krita
              self.homeManagerModules.zoxide
              self.homeManagerModules.direnv
              # self.homeManagerModules.emacs
            ];

            home.packages = with pkgs; [
              hyprshot
              chatterino7
              playerctl
              thunderbird
              # aseprite

              # onlyoffice-desktopeditors
              # inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
            ];

            programs.vesktop.enable = true;

            home.stateVersion = "26.05";
            home.username = "samson";
            programs.home-manager.enable = true;
            home.homeDirectory = "/home/samson";
          };
      };

      environment.systemPackages = [
        pkgs.vim
        pkgs.openvpn
        pkgs.anki-bin
        pkgs.reaper
        pkgs.rapidraw
        inputs.sheets.packages.${pkgs.stdenv.hostPlatform.system}.default
        inputs.hytale-launcher.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];

      environment.shells = [
        pkgs.nushell
      ];

      services.asusd = {
        enable = true;
      };

      networking.firewall.allowedTCPPorts = [
        8384
        22000
      ];
      networking.firewall.allowedUDPPorts = [
        22000
        21027
      ];
      services.syncthing = {
        user = "samson";
        group = "users";
        configDir = "/home/samson/.config/syncthing";
        enable = true;
        openDefaultPorts = true;
        settings = {
          devices = {
            "SM-T733" = {
              id = "55KNMUI-QFAUIGX-2ZO75HJ-WVCFIML-34TBG4D-SMJWDPH-XOY73YI-5OG4XQS";
            };
          };

          folders = {
            "RAM" = {
              path = "/home/samson/RAM";
              devices = [ "SM-T733" ];
            };
          };

          gui.user = "samson";
        };
      };

      programs.bash.enable = true;
      programs.bash.interactiveShellInit = ''
        if ! [ "$TERM" = "dumb" ] && [ -z "$BASH_EXECUTION_STRING" ]; then
          exec nu
        fi
      '';

      stylix = {
        enable = true;
        image = pkgs.fetchurl {
          url = "https://w.wallhaven.cc/full/21/wallhaven-213edy.png";
          hash = "sha256-5fnOaB4ozW49gJFGZKpVfGMTo8EaFTPT4b6EIr4lcKA=";
        };
        base16Scheme = "${pkgs.base16-schemes}/share/themes/helios.yaml";
        polarity = "either";
        fonts = {
          monospace = {
            package = pkgs.nerd-fonts.lilex;
            name = "Lilex Nerd Font Mono";
          };
        };
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
          pkgs.xdg-desktop-portal-hyprland
          pkgs.xdg-desktop-portal-gtk
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
        pkgs.font-awesome_4
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
      nix.settings = {
        substituters = [ "https://hyprland.cachix.org" ];
        trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
      };

      system.stateVersion = "26.05";
    };
}
