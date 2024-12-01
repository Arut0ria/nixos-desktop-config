{ config, lib, ... }: {
  # config = lib.mkIf config.hyprland-module.enable {
  config = {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        "$mod" = "SUPER";

        bindm = [
          # mouse movements
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
          "$mod ALT, mouse:272, resizewindow"
          "$mod T, exec, kitty"
        ];
      };
    };
  };
}
