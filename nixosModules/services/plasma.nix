{ pkgs, lib, config, ... }: {
  options = {
    plasma-module = lib.mkEnableOption "Enables plasma";
  };

  config = lib.mkIf config.plasma-module.enable {
    services = {
      xserver.enable = true;
      displayManager = {
        defaultSession = "plasma";
        sddm.enable = true;
      };

      desktopManager.plasma6.enable = true;
    };
  };
}
