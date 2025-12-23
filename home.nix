{ pkgs, ... }:

{
  imports = [
    ./hyprland.nix
  ];

  home.stateVersion = "25.11";

  programs.home-manager.enable = true;
  home.username = "samson";
  home.homeDirectory = "/home/samson";

  home.packages = with pkgs; [
    eza
    blueman
  ];
 
  programs.kitty.enable = true;
  programs.kitty.settings.confirm_os_window_close = 0;

  programs.rofi.enable = true;
  programs.firefox.enable = true;

  programs.git = {
    enable = true;
    settings = {
      user.name = "Samson Liebscher";
      user.email = "samson.gw21@gmail.com";
      safe.directory = "/etc/nixos";
    };
  };

  programs.bash = {
    enable = true;

    initExtra = ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  programs.fish.shellAliases = {
    tree = "eza -Ta --icons=always";
    ls = "eza --icons=always";
    ll = "eza --icons=always -la";
  };

  programs.fish = {
    enable = true;

    functions = {
      fish_prompt = ''
        set -l last_pipestatus $pipestatus
        set -lx __fish_last_status $status

        # Nix shell indicator
        set -l nix_indicator ""
        if set -q IN_NIX_SHELL
          set nix_indicator [nix]
        end

        # Git branch indicator
        set -l git_indicator ""
        if type -q git; and functions -q fish_git_prompt
          set git_indicator (set_color red)(fish_git_prompt "(%s) ")
        end

        # Status indicator (only shown if non-zero)
        set -l last_status $status
        set -l stat ""
        if test $last_status -ne 0
          set stat (set_color red --bold)"[$last_status]"(set_color normal)
        end

        # Root user prompt
        if functions -q fish_is_root_user; and fish_is_root_user
          printf '%s@%s %s%s%s# ' \
            $USER \
            (prompt_hostname) \
            (set -q fish_color_cwd_root; and set_color $fish_color_cwd_root; or set_color $fish_color_cwd) \
            (prompt_pwd) \
            (set_color normal)
        else
          # Regular user prompt
          set -l TIME (date "+%H:%M:%S")
   
          printf '[%s] %s%s@%s %s\n' \
            $TIME \
            (set_color blue) \
            $USER \
            (prompt_hostname) \
            (set_color red)(prompt_pwd)(set_color normal)
          printf '%s%s%s> ' \
            $git_indicator \
            $stat \
            $nix_indicator
        end
      ''; 
    };


    interactiveShellInit = ''
      set fish_greeting "" # Disable greeting
    '';
  };
}
