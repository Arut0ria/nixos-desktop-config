{ pkgs, lib, config, ... }@inputs: {
  options = {
    plasma-module.enable = lib.mkEnableOption "Enables plasma";
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

    environment.systemPackages = lib.optionals (builtins.hasAttr "kwin-effects-forceblur" inputs.inputs) [
      inputs.inputs.kwin-effects-forceblur.packages.${pkgs.system}.default
    ];
  };
}
