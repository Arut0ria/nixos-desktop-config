{ pkgs, lib, config, ... }: {
  options = {
    stylix-module.enable = lib.mkEnableOption "Enables stylix.";
  };

  config = lib.mkIf config.stylix-module.enable {
    # Enable stylix
    stylix = {
      enable = true;
      autoEnable = true;
      image = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/Arut0ria/nixos-desktop-config/main/images/672183.jpg";
        sha256 = "0g0z89miryai32w51q2is7p18pwg1mx6jcagjxbaiaamf35hx4wa";
      };

      polarity = "dark";

      opacity = {
        terminal = 0.9;
        popups = 0.9;
        applications = 0.95;
        desktop = 0.9;
      };

      targets = {
        grub.useImage = true;
      };

      override.base05 = "FFFFFF";

      fonts = {
        serif = {
          package = pkgs.noto-fonts-cjk-serif;
          name = "Noto Serif";
        };

        sansSerif = {
          package = pkgs.noto-fonts-cjk-sans;
          name = "Noto Sans";
        };

        monospace = {
          package = pkgs.jetbrains-mono;
          name = "JetBrains Mono";
        };

        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };
    };
  };
}
