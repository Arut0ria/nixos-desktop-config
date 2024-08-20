{ pkgs, config, lib, ... }: {
  options = {
    retroarch-program.enable = lib.mkEnableOption "Enables retroarch";
  };

  config = lib.mkIf config.retroarch-program.enable {
    environment.systemPackages = with pkgs; [
      (retroarch.override {
        cores = with libretro; [
          beetle-psx-hw
          # pcsx2
          citra
        ];
      })
      pcsx2
    ];
  };
}
