{ config, lib, pkgs, ... }@inputs: {
  options = {
    hyprland-module.enable = lib.mkEnableOption "Enables hyprland";
  };

  config = lib.mkIf config.hyprland-module.enable {
    programs.hyprland = {
      enable = true;
      package = inputs.inputs.hyprland.packages."${pkgs.system}".hyprland;
    };
  };
}
