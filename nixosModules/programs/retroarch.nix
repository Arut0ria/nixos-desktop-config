{ pkgs, config, lib, ... }: {
  options = {
    retroarch-program.enable = lib.mkEnableOption "Enables retroarch";
  };

  config = lib.mkIf config.retroarch-program.enable {
    environment.systemPackages = with pkgs; [
      (retroarch.override {
        cores = with libretro; [
          beetle-psx-hw
          beetle-psx
          # pcsx2
          citra
          snes9x2010
          nestopia
          picodrive
        ];
      })
      pcsx2
      rpcs3
    ];
  };
}
