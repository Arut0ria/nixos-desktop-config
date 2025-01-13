{ pkgs, lib, config, ... }: {
  options = {
    nvidia-module.enable = lib.mkEnableOption "Enables Nvidia.";
  };

  config = lib.mkIf config.nvidia-module.enable {
    hardware.opengl = {
      enable = true;
      # driSupport = true;
      driSupport32Bit = true;
    };

    hardware.nvidia = {
      package = config.boot.kernelPackages.nvidiaPackages.stable;
      modesetting.enable = true;
      powerManagement.enable = true;
      open = false;
      nvidiaSettings = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];
  };
}
