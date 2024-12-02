{ lib, ... }:
{
  /**
    Zram setup
  */
  zramSwap = {
    enable = true;
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
