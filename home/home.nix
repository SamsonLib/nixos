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
    discord
    obsidian
    ripgrep
    wget
    (jetbrains.idea-oss.override {
	
    })
    jdk25
    curl
    krita
    brave
    yazi
    blender
    gimp
    anki
    filezilla
    kdePackages.kate
    libreoffice
    nil
    nixd
    zed-editor
  ];

  programs.kitty = {
    enable = true;

    settings = {
      shell = "fish";
      show_hyperlink_targets = "yes";
      enable_audio_bell = false;
      confirm_os_window_close = 0;
      font_family = "Lilex Nerd Font Mono";
      features = "+zero +ss04 +ss01";
    };
  };

  programs.rofi.enable = true;
  programs.firefox.enable = true;

  programs.zoxide.enable = true;
  programs.bat.enable = true;
  programs.fzf.enable = true;

  # stylix.targets.neovim.enable = false;

  programs.neovim = {
    enable = true;

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      telescope-nvim
      conform-nvim
      nvim-autopairs
      comment-nvim
      lualine-nvim
      blink-cmp
      todo-comments-nvim
      trouble-nvim
      undotree
      mini-nvim
      mini-base16
      neo-tree-nvim
    ];

    extraPackages = with pkgs; [
      # formatters
      ruff
      stylua
      alejandra

      # language servers
      pyright
      lua-language-server
      nil
    ];

    extraLuaConfig = ''
      vim.g.mapleader = " "
      vim.opt.relativenumber = true
    '';
  };

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
