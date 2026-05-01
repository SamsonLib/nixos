{ ... }:
{
  flake.homeManagerModules.hyprland =
    { pkgs, ... }:
    {
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

      wayland.windowManager.hyprland = {
        enable = true;

        plugins = [
          pkgs.hyprlandPlugins.hyprsplit
        ];

        settings = {
          monitor = [
            "HDMI-A-1,1920x1080@75,1920x0,1"
            "DP-3,1920x1080@180,0x0,1"
          ];

          input = {
            kb_layout = "us, de";
            kb_variant = "dvp";
            kb_options = "caps:escape,grp:alt_space_toggle";
          };

          device = {
            name = "sec_e-pen";
            output = "HDMI-A-1";
            transform = "3";
            rotation = "90";
          };

          animations.enabled = "false";

          general.gaps_out = "0";
          general.gaps_in = "0";

          "$terminal" = "kitty";
          "$menu" = "pkill rofi || rofi -show drun";
          "$window_selector" = "pkill rofi || rofi -show window";
          "$browser" = "firefox";
          "$browser_private" = "firefox --private-window";
          "$screenshot" = "hyprshot -m region";

          "$mainMod" = "SUPER";
          bind = [
            "$mainMod, return, exec, $terminal"
            "$mainMod, space, exec, $menu"
            "$mainMod, Semicolon, killactive"
            "$mainMod, w, exec, $window_selector"
            "$mainMod, x, exec, $browser"
            "$mainMod, f, fullscreen,"
            "$mainMod, v, togglefloating,"
            "$mainMod SHIFT, x, exec, $browser_private"
            "$mainMod SHIFT, s, exec, $screenshot"

            "$mainMod, h, movefocus, l"
            "$mainMod, l, movefocus, r"
            "$mainMod, k, movefocus, u"
            "$mainMod, j, movefocus, d"

            "$mainMod SHIFT, h, movewindow, l"
            "$mainMod SHIFT, l, movewindow, r"
            "$mainMod SHIFT, k, movewindow, u"
            "$mainMod SHIFT, j, movewindow, d"

            "$mainMod, Ampersand, split:workspace, 1"
            "$mainMod, Bracketleft, split:workspace, 2"
            "$mainMod, Braceleft, split:workspace, 3"
            "$mainMod, Braceright, split:workspace, 4"
            "$mainMod, Parenleft, split:workspace, 5"
            "$mainMod, Equal, split:workspace, 6"
            "$mainMod, Asterisk, split:workspace, 7"
            "$mainMod, Parenright, split:workspace, 8"
            "$mainMod, Plus, split:workspace, 9"
            "$mainMod, Bracketright, split:workspace, 10"

            "$mainMod SHIFT, Ampersand, split:movetoworkspace, 1"
            "$mainMod SHIFT, Bracketleft, split:movetoworkspace, 2"
            "$mainMod SHIFT, Braceleft, split:movetoworkspace, 3"
            "$mainMod SHIFT, Braceright, split:movetoworkspace, 4"
            "$mainMod SHIFT, Parenleft, split:movetoworkspace, 5"
            "$mainMod SHIFT, Equal, split:movetoworkspace, 6"
            "$mainMod SHIFT, Asterisk, split:movetoworkspace, 7"
            "$mainMod SHIFT, Parenright, split:movetoworkspace, 8"
            "$mainMod SHIFT, Plus, split:movetoworkspace, 9"
            "$mainMod SHIFT, Bracketright, split:movetoworkspace, 10"
          ];

          bindm = [
            "$mainMod, mouse:272, movewindow"
            "$mainMod, mouse:273, resizewindow"
          ];

          windowrule = [
            "match:class .*, suppress_event maximize"
            "match:class ^$, match:title ^$,match:xwayland true,match:float true,match:fullscreen true,match:pin true, no_initial_focus on"
          ];
        };
      };
    };
}
