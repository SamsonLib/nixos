{ ... }:
{
  flake.homeManagerModules.waybar =
    { ... }:
    {
      programs.waybar = {
        enable = true;
        style = ''
          #workspaces button.empty {
              min-width: 0px !important;
              min-height: 0px !important;
              padding: 0px !important;
              margin: 0px !important;
              border: none !important;
              font-size: 0;
              opacity: 0;
          }
        '';
        settings = {
          mainBar = {
            layer = "top";
            position = "top";
            height = 20;
            output = [
              "DP-3"
              "HDMI-A-1"
            ];
            modules-left = [
              "hyprland/workspace-taskbar"
            ];
            modules-center = [
            ];
            modules-right = [
              "hyprland/workspaces"
            ];

            "hyprland/workspaces" = {
              format = "{name}";
              all-outputs = false;
              show-special = false;
              sort-by-number = true;
              persistent-workspaces = { };
            };
          };
        };
      };
    };
}
