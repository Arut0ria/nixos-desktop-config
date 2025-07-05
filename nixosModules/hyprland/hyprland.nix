{ config, lib, pkgs, ... }@args: {
  options = {
    hyprland-module.enable = lib.mkEnableOption "Enables hyprland";
  };

  config = lib.mkIf config.hyprland-module.enable {
    programs.hyprland = {
      enable = true;
      package = args.inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}".hyprland;
      portalPackage = args.inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };
}
