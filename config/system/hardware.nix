{ lib, ... }:
{
  /**
    Zram setup
  */
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 80;
  };

  hardware = {

    /**
      Bluetooth setup
    */
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
