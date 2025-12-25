{ pkgs, ... }:

{
  imports = [
    ./hyprland.nix
    ./fish.nix
  ];

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
  home.username = "samson";
  home.homeDirectory = "/home/samson";

  home.packages = with pkgs; [
    vscode
    eza
    blueman
    (prismlauncher.override {
      jdks = [
        jdk25_headless
	jdk8
      ];
    })
  ];

  programs.kitty.enable = true;
  programs.kitty.settings.confirm_os_window_close = 0;

  programs.rofi.enable = true;
  programs.firefox.enable = true;

  programs.zoxide.enable = true;

  programs.direnv = {
    enable = true;
    # enableFishIntegration = lib.mkForce true;
    nix-direnv.enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Samson Liebscher";
      user.email = "samson.gw21@gmail.com";
      safe.directory = "/etc/nixos";
    };
  };
}
