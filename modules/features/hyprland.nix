{ self, inputs, ... }:
{
  flake.nixosModules.hyprland =
    { pkgs, lib, ... }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.myHyprland
      ];

      programs.hyprland = {
        enable = true;
        package = self.packages.${pkgs.stdenv.hostPlatform.system}.myHyprland;
      };
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.myHyprland =
        let
          hyprsplit = pkgs.hyprlandPlugins.hyprsplit;
          hyprlandConf = pkgs.writeText "hyprland.conf" ''
            exec-once = ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd \
              DISPLAY HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY \
              XDG_CURRENT_DESKTOP XDG_SESSION_TYPE \
              && systemctl --user stop hyprland-session.target \
              && systemctl --user start hyprland-session.target
            exec-once = hyprctl plugin load ${hyprsplit}/lib/libhyprsplit.so

            $browser = firefox
            $browser_private = firefox --private-window
            $mainMod = SUPER
            $menu = pkill rofi || rofi -show drun
            $screenshot = hyprshot -m region
            $terminal = kitty
            $window_selector = pkill rofi || rofi -show window

            animations {
              enabled = false
            }

            bind = $mainMod, return, exec, $terminal
            bind = $mainMod, space, exec, $menu
            bind = $mainMod, Semicolon, killactive
            bind = $mainMod, w, exec, $window_selector
            bind = $mainMod, x, exec, $browser
            bind = $mainMod, f, fullscreen,
            bind = $mainMod, v, togglefloating,
            bind = $mainMod SHIFT, x, exec, $browser_private
            bind = $mainMod SHIFT, s, exec, $screenshot
            bind = $mainMod, h, movefocus, l
            bind = $mainMod, l, movefocus, r
            bind = $mainMod, k, movefocus, u
            bind = $mainMod, j, movefocus, d
            bind = $mainMod SHIFT, h, movewindow, l
            bind = $mainMod SHIFT, l, movewindow, r
            bind = $mainMod SHIFT, k, movewindow, u
            bind = $mainMod SHIFT, j, movewindow, d
            bind = $mainMod, Ampersand,    split:workspace, 1
            bind = $mainMod, Bracketleft,  split:workspace, 2
            bind = $mainMod, Braceleft,    split:workspace, 3
            bind = $mainMod, Braceright,   split:workspace, 4
            bind = $mainMod, Parenleft,    split:workspace, 5
            bind = $mainMod, Equal,        split:workspace, 6
            bind = $mainMod, Asterisk,     split:workspace, 7
            bind = $mainMod, Parenright,   split:workspace, 8
            bind = $mainMod, Plus,         split:workspace, 9
            bind = $mainMod, Bracketright, split:workspace, 10
            bind = $mainMod SHIFT, Ampersand,    split:movetoworkspace, 1
            bind = $mainMod SHIFT, Bracketleft,  split:movetoworkspace, 2
            bind = $mainMod SHIFT, Braceleft,    split:movetoworkspace, 3
            bind = $mainMod SHIFT, Braceright,   split:movetoworkspace, 4
            bind = $mainMod SHIFT, Parenleft,    split:movetoworkspace, 5
            bind = $mainMod SHIFT, Equal,        split:movetoworkspace, 6
            bind = $mainMod SHIFT, Asterisk,     split:movetoworkspace, 7
            bind = $mainMod SHIFT, Parenright,   split:movetoworkspace, 8
            bind = $mainMod SHIFT, Plus,         split:movetoworkspace, 9
            bind = $mainMod SHIFT, Bracketright, split:movetoworkspace, 10

            bindm = $mainMod, mouse:272, movewindow
            bindm = $mainMod, mouse:273, resizewindow

            device {
              name = sec_e-pen
              output = HDMI-A-1
              rotation = 90
              transform = 3
            }

            general {
              gaps_in = 0
              gaps_out = 0
            }

            input {
              kb_layout = us, de
              kb_options = caps:escape,grp:alt_space_toggle
              kb_variant = dvp
            }

            monitor = HDMI-A-1, 1920x1080@75,  1920x0, 1
            monitor = DP-3,     1920x1080@180, 0x0,    1

            windowrule = match:class .*, suppress_event maximize
            windowrule = match:class ^$, match:title ^$, match:xwayland true, match:float true, match:fullscreen true, match:pin true, no_initial_focus on
          '';
        in
        inputs.wrapper-modules.lib.wrapPackage (
          { ... }:
          {
            inherit pkgs;
            package = pkgs.hyprland;
            env.HYPRLAND_CONFIG = "${hyprlandConf}";
          }
        );
    };
}
