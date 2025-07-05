{ pkgs, lib, ... }: {
  imports = [
    ./dunst.nix
    ./waybar.nix

    ./hyprland.nix
  ];

  dunst-module.enable = lib.mkDefault true;
  waybar-module.enable = lib.mkDefault true;
}
