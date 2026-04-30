{ pkgs, lib, ... }:

{
  imports = [
    ./hyprland.nix
    ./fish.nix
    ./kitty.nix
    ./git.nix
  ];

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
    heroic
    nixd
    hyprshot
    flow-control
    wireguard-tools
    protonvpn-gui
    openrgb-with-all-plugins
    aseprite
    fzf
    firefox
    prusa-slicer
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
