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
      # opacity.terminal = 0.1;
      targets = {
        grub.useImage = true;
      };
    };
  };
}