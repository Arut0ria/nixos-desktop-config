{ config, lib, ... }: {
  # config = lib.mkIf config.hyprland-module.enable {
  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";

        exec-once = [ ]
          ++ lib.optionals (config.waybar-module.enable) [ "waybar" ]
          ++ lib.optionals (config.dunst-module.enable) [ "dunst" ];

        input = {
          kb_layout = "fr";
          touchpad = {
            natural_scroll = true;
          };
        };

        gestures = {
          workspace_swipe = true;
        };

        general = {
          gaps_in = 2;
          gaps_out = 2;
        };

        bezier = [
          "ease-out-expo, 0.16, 1, 0.3, 1"
        ];

        animation = [
          "workspaces, 1, 10, ease-out-expo, slide"
        ];

        bindm = [
          # mouse movements
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
          "$mod ALT, mouse:272, resizewindow"
        ];

        bind = [
          "$mod, T, exec, kitty"
          "$mod, F, exec, firefox"

          "$mod CTRL, right, workspace, +1"
          "$mod CTRL, left, workspace, -1"

          "$mod CTRL_SHIFT, right, movetoworkspace, +1"
          "$mod CTRL_SHIFT, left, movetoworkspace, -1"

          "$mod ALT, left, movefocus, l"
          "$mod ALT, down, movefocus, d"
          "$mod ALT, up, movefocus, u"
          "$mod ALT, right, movefocus, r"

          "$mod ALT CTRL_ALT, left, movewindow, l"
          "$mod ALT CTRL_ALT, down, movewindow, d"
          "$mod ALT CTRL_ALT, up, movewindow, u"
          "$mod ALT CTRL_ALT, right, movewindow, r"
        ];

        bindl = [
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

          ",XF86AudioPlay, exec, playerctl play-pause"
          ",XF86AudioPause, exec, playerctl play-pause"

          ",XF86AudioNext, exec, playerctl next"
          ",XF86AudioPrev, exec, playerctl previous"

          ",XF86MonBrightnessDown,exec,brightnessctl set 5%-"
          ",XF86MonBrightnessUp,exec,brightnessctl set +5%"
        ];

        bindle = [
          ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ];
      };
    };
  };
}
