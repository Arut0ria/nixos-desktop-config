{ pkgs, config, lib, ... }: {
  options = {
    fastfetch-program.enable = lib.mkEnableOption "Enables Fastfetch";
  };

  config = lib.mkIf config.fastfetch-program.enable {
    programs.fastfetch = {
      enable = true;
      package = pkgs.fastfetch;
      settings = {
        "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
        logo = {
          source = pkgs.fetchurl {
            # url = "https://raw.githubusercontent.com/Arut0ria/nixos-desktop-config/main/images/term_logo.jpg";
            url = "https://raw.githubusercontent.com/Arut0ria/nixos-desktop-config/main/images/term_logo_2.jpg";
            sha256 = "174bvzc9qgbjizzmx7lwdv7bl2bjlc0g0r4n2psd5hakjlglalma";
          };
          # width = 64;
          height = 18;
          # source = "/home/theo/nixos-desktop-config/images/term_logo.jpg";
          type = "kitty";
          printRemaining = true;
          preserveAspectRatio = true;
          padding = {
            top = 1;
            left = 2;
          };
        };
        display = {
          color = {
            keys = "green";
            title = "blue";
          };
          percent = {
            type = 9;
          };
          separator = ": ";
        };
        modules =
          [
            {
              type = "custom";
              outputColor = "blue";
              format = ''┌──────────── OS Information ────────────┐'';
            }
            {
              type = "title";
              key = " ╭─  ";
              keyColor = "green";
              color = {
                user = "green";
                host = "green";
              };
            }
          ]
          ++ lib.optionals pkgs.stdenv.isLinux [
            {
              type = "os";
              key = " ├─  ";
              keyColor = "green";
            }
            {
              type = "kernel";
              key = " ├─  ";
              keyColor = "green";
            }
            {
              type = "packages";
              key = " ├─ 󰏗 ";
              keyColor = "green";
            }
          ]
          ++ [
            {
              type = "shell";
              key = " ╰─  ";
              keyColor = "green";
            }
            {
              type = "custom";
              outputColor = "blue";
              format = ''├───────── Hardware Information ─────────┤'';
            }
            {
              type = "display";
              key = " ╭─ 󰍹 ";
              keyColor = "blue";
              compactType = "original-with-refresh-rate";
            }
            {
              type = "cpu";
              key = " ├─  ";
              keyColor = "blue";
            }
            {
              type = "gpu";
              key = " ├─ 󰂵 ";
              keyColor = "blue";
            }
            {
              type = "disk";
              key = " ├─ 󰋊 ";
              keyColor = "blue";
            }
            {
              type = "memory";
              key = " ╰─  ";
              keyColor = "blue";
            }
            {
              type = "custom";
              outputColor = "blue";
              format = ''├───────── Software Information ─────────┤'';
            }
            {
              type = "wm";
              key = " ╭─  ";
              keyColor = "yellow";
            }
            {
              type = "terminal";
              key = " ├─ 󰞷 ";
              keyColor = "yellow";
            }
            {
              type = "font";
              key = " ╰─  ";
              keyColor = "yellow";
            }
            {
              type = "custom";
              outputColor = "blue";
              format = ''└────────────────────────────────────────┘'';
            }
            {
              type = "colors";
              symbol = "circle";
              block.width = 5;
              paddingLeft = 2;
            }
            # {
            #   type = "custom";
            #   format = "   {#39}   {#34}    {#36}    {#35}    {#34}    {#33}    {#32}    {#31} ";
            # }
            "break"
          ];
      };
    };
  };
}
