{ ... }:
{
  flake.homeManagerModules.kitty =
    { ... }:
    {
      programs.kitty = {
        enable = true;
        settings = {
          shell = "nu";
          show_hyprlink_targets = "yes";
          enable_audio_bell = false;
          confirm_os_window_close = 0;
          font_family = "Lilex Nerd Font Mono";
          features = "+zero +ss04 +ss01";
        };
      };
    };
}
