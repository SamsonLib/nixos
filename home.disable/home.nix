{ pkgs, lib, ... }:

{
  imports = [
    ./hyprland.nix
    ./fish.nix
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "Samson Liebscher";
      user.email = "samson.gw21@gmail.com";
      safe.directory = "/etc/nixos/";
    };
  };

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
  home.username = "samson";
  home.homeDirectory = "/home/samson";

  home.packages = with pkgs; [
    eza
    blueman
    (prismlauncher.override {
      jdks = [
        graalvmPackages.graalvm-ce
        jdk17
        jdk21
        jdk8_headless
        jre8
      ];
    })
    obsidian
    wget
    blockbench
    nil
    nixd
    hyprshot
    flow-control
    wireguard-tools
    protonvpn-gui
    fzf
    firefox
    hyprcursor
    krita
    ffmpeg
    godot
    anki
    vscode
    zed-editor
    (blender.override {
      cudaSupport = true;
    })
    chatterino7
    (nemo-with-extensions.override {
      extensions = with pkgs; [
        nemo-seahorse
        nemo-python
        nemo-preview
        nemo-fileroller
        nemo-emblems
      ];
    })
  ];

  programs.wpaperd.enable = true;

  dconf = {
    settings = {
      "org/cinnamon/desktop/applications/terminal" = {
        exec = "kitty";
      };
    };
  };

  programs.kitty = {
    enable = true;
    settings = {
      shell = "fish";
      show_hyprlink_targets = "yes";
      enable_audio_bell = false;
      confirm_os_window_close = 0;
      font_family = "Lilex Nerd Font Mono";
      features = "+zero +ss04 +ss01";
    };
  };

  home.pointerCursor =
    let
      getFrom = url: hash: name: {
        gtk.enable = true;
        x11.enable = true;
        hyprcursor.enable = true;
        hyprcursor.size = 10;
        name = name;
        size = 10;
        package = pkgs.runCommand "moveUp" { } ''
          mkdir -p $out/share/icons
          ln -s ${
            pkgs.fetchzip {
              url = url;
              hash = hash;
            }
          } $out/share/icons/${name}
        '';
      };
    in
    getFrom
      "https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata-Modern-Classic.tar.xz"
      "sha256-2Fd0OVSCgFZVLRAVo/MxgHp1qK5WUNhKY685XPYrBmk="
      "Bibata_Cursor";

  programs.rofi.enable = true;
  programs.bat.enable = true;
  programs.zoxide = {
    enableFishIntegration = true;
    enable = true;
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
