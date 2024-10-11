{ pkgs, lib, config, ... }:
let
  background = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/Arut0ria/nixos-desktop-config/main/images/672183.jpg";
    sha256 = "0g0z89miryai32w51q2is7p18pwg1mx6jcagjxbaiaamf35hx4wa";
  };

  # logo = pkgs.fetchurl {
  #   # url = "https://raw.githubusercontent.com/Arut0ria/nixos-desktop-config/main/images/term_logo.jpg";
  #   url = "https://raw.githubusercontent.com/Arut0ria/nixos-desktop-config/main/images/term_logo_2.jpg";
  #   sha256 = "174bvzc9qgbjizzmx7lwdv7bl2bjlc0g0r4n2psd5hakjlglalma";
  # };
  # logo = pkgs.stdenv.mkDerivation {
  #   name = "sddm_logo";
  #   src = "nixosModules/programs/custom_nix_logo.svg";
  #   dontUnpack = true;
  #   installPhase = ''
  #     mkdir -p $out
  #     cp custom_nix_logo.svg share/sddm/themes/breeze/theme.conf.user
  #   '';
  # };
in
{
  options = {
    stylix-module.enable = lib.mkEnableOption "Enables stylix.";
  };

  config = lib.mkIf config.stylix-module.enable {
    environment.systemPackages = [
      (pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
        [General]
        background=${background}
      '')
    ];

    # Enable stylix
    stylix = {
      enable = true;
      autoEnable = true;
      image = background;

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
