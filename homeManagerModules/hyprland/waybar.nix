{ config, pkgs, lib, ... }: {
  options = {
    waybar-module.enable = lib.mkEnableOption "Enables waybar";
    waybar-display-backlight = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };

    waybar-display-battery = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };

  config = lib.mkIf config.waybar-module.enable {
    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;
          spacing = 4;

          # Modules
          modules-left = [ ];

          modules-center = [ ];

          modules-right = [
            "network"
            "clock"
          ]
          ++ (lib.optional config.waybar-display-backlight "backlight")
          ++ (lib.optional config.waybar-display-battery "battery");

          network = {
            # "interface" = "wlp2*", # (Optional) To force the use of this interface
            format-wifi = "{essid} ({signalStrength}%) ";
            format-ethernet = "{ipaddr}/{cidr} ";
            tooltip-format = "{ifname} via {gwaddr} ";
            format-linked = "{ifname} (No IP) ";
            format-disconnected = "Disconnected ⚠";
            format-alt = "{ifname}: {ipaddr}/{cidr}";
          };

          backlight = lib.mkIf config.waybar-display-backlight {
            # TODO
          };

          battery = lib.mkIf config.waybar-display-battery {
            # TODO
          };
        };
      };
      style = lib.mkAfter (builtins.readFile ./waybar_style.css);
    };
  };
}
