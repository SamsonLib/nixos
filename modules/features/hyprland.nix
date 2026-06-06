{ inputs, ... }:
{
  flake.homeManagerModules.hyprland =
    { pkgs, ... }:
    {
      imports = [
      ];

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
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

        portalPackage =
          inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

        plugins = [
          inputs.split-monitor-workspaces.packages.${pkgs.stdenv.hostPlatform.system}.split-monitor-workspaces
        ];

        extraConfig = ''
          --------------------
          ---- MONITORS -----
          --------------------

          hl.monitor({
            output   = "HDMI-A-1",
            mode     = "1920x1080@75",
            position = "1920x0",
            scale    = 1,
          })

          hl.monitor({
            output   = "DP-3",
            mode     = "1920x1080@180",
            position = "0x0",
            scale    = 1,
          })

          --------------------
          ---- DEVICES ------
          --------------------

          hl.device({
            name      = "sec_e-pen",
            output    = "HDMI-A-1",
            transform = 3,  -- 3 = 90 degrees
          })

          --------------------
          ---- INPUT --------
          --------------------

          hl.config({
            input = {
              kb_layout  = "us, de",
              kb_variant = "dvp",
              kb_options = "caps:escape,grp:alt_space_toggle",
            },
          })

          --------------------
          ---- LOOK & FEEL --
          --------------------

          hl.config({
            general = {
              gaps_in  = 0,
              gaps_out = 0,
            },

            decoration = {
              blur   = { enabled = false },
              shadow = { enabled = false },
            },

            animations = {
              enabled = false,
            },
          })

          --------------------
          ---- PLUGINS ------
          --------------------

          -- hyprsplit: per-monitor independent workspace sets
          -- hl.config({
          --   plugin = {
          --     hyprsplit = {
          --       num_workspaces = 10,
          --     },
          --   },
          -- })

          hl.config({
            plugin = {
              split_monitor_workspaces = {
                count = 10,
              },
            },
          })
          local smw = hl.plugin.split_monitor_workspaces
          smw.monitor_priority({ "HDMI-A-1", "DP-3" })

          --------------------
          ---- VARIABLES ----
          --------------------

          local mainMod         = "SUPER"
          local terminal        = "kitty"
          local menu            = "pkill rofi || rofi -show drun"
          local window_selector = "pkill rofi || rofi -show window"
          local browser         = "firefox"
          local browser_private = "firefox --private-window"
          local screenshot      = "hyprshot -m region"

          --------------------
          ---- KEYBINDS -----
          --------------------

          hl.bind(mainMod .. " + return",    hl.dsp.exec_cmd(terminal))
          hl.bind(mainMod .. " + space",     hl.dsp.exec_cmd(menu))
          hl.bind(mainMod .. " + Semicolon", hl.dsp.window.close())
          hl.bind(mainMod .. " + w",         hl.dsp.exec_cmd(window_selector))
          hl.bind(mainMod .. " + x",         hl.dsp.exec_cmd(browser))
          hl.bind(mainMod .. " + f",         hl.dsp.window.fullscreen())
          hl.bind(mainMod .. " + v",         hl.dsp.window.float({ action = "toggle" }))
          hl.bind(mainMod .. " + SHIFT + x", hl.dsp.exec_cmd(browser_private))
          hl.bind(mainMod .. " + SHIFT + s", hl.dsp.exec_cmd(screenshot))

          -- Focus movement (HJKL)
          hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
          hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
          hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
          hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

          -- Window movement (HJKL)
          hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
          hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))
          hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
          hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))

          local ws_keys = {
            "Ampersand", "Bracketleft", "Braceleft", "Braceright", "Parenleft",
            "Equal", "Asterisk", "Parenright", "Plus", "Bracketright",
          }
          local swm = hl.plugin.split_monitor_workspaces
          for i, key in ipairs(ws_keys) do
            hl.bind(mainMod .. " + " .. key, function()
              return swm.workspace(i)
            end)
            hl.bind(mainMod .. " + SHIFT + " .. key, function()
              return swm.move_to_workspace(i)
            end)
            hl.bind(mainMod .. " + CTRL + " .. key, function()
              return swm.move_to_workspace_silent(i)
            end)
          end

          -- Special / scratchpad workspace
          hl.bind(mainMod .. " + O", hl.dsp.workspace.toggle_special())
          hl.bind(mainMod .. " + SHIFT + O", hl.dsp.window.move({ workspace = "special:magic" }))

          hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
          hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
          hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
          hl.bind("XF86AudioStop",  hl.dsp.exec_cmd("playerctl stop"),       { locked = true })
          hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
          hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
          hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
          hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
          hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
          hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
          hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })


          -- Mouse window controls
          hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
          hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

          --------------------
          ---- WINDOW RULES -
          --------------------

          hl.window_rule({
            name           = "suppress-maximize",
            match          = { class = ".*" },
            suppress_event = "maximize",
          })

          hl.window_rule({
            name         = "xwayland-border",
            match        = { xwayland = true },
            border_color = 0xffff0000,
          })

          hl.window_rule({
            name  = "fix-xwayland-drags",
            match = {
              class      = "^$",
              title      = "^$",
              xwayland   = true,
              float      = true,
              fullscreen = false,
              pin        = false,
            },
            no_focus = true,
          })
        '';
      };
    };
}
