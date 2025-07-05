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
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "570.133.07";
        sha256_64bit = "sha256-LUPmTFgb5e9VTemIixqpADfvbUX1QoTT2dztwI3E3CY=";
        sha256_aarch64 = "sha256-yTovUno/1TkakemRlNpNB91U+V04ACTMwPEhDok7jI0=";
        openSha256 = "sha256-9l8N83Spj0MccA8+8R1uqiXBS0Ag4JrLPjrU3TaXHnM=";
        settingsSha256 = "sha256-XMk+FvTlGpMquM8aE8kgYK2PIEszUZD2+Zmj2OpYrzU=";
        persistencedSha256 = "sha256-G1V7JtHQbfnSRfVjz/LE2fYTlh9okpCbE4dfX9oYSg8=";
      };
      modesetting.enable = true;
      powerManagement.enable = true;
      open = false;
      nvidiaSettings = true;
    };

    services.xserver.videoDrivers = [ "nvidia" ];
  };
}
