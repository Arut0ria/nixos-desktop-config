{ config, lib, pkgs, ... }: {
  options = {
    dunst-module.enable = lib.mkEnableOption "Enables Dunst";
  };

  config = lib.mkIf config.dunst-module.enable {
    # services.dunst.enable = true;
    home.packages = with pkgs; [
      dunst
    ];
  };
}
