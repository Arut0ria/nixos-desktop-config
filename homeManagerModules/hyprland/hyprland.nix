{ config, lib, ... }: {
  # config = lib.mkIf config.hyprland-module.enable {
  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";
        
        input = {
          kb_layout = "fr";
        };

        general = {
          gaps_in = 2;
          gaps_out = 2;
        };

        bindm = [
          # mouse movements
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
          "$mod ALT, mouse:272, resizewindow"
        ];
        bind = [
          "$mod, T, exec, kitty"
        ];
      };
    };
  };
}
