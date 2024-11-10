{pkgs, lib, config, ...}: {
  options = {
    homePackages.enable = lib.mkEnableOption "Addtional packages.";
  };

  config = lib.mkIf config.homePackages.enable {
    home.packages = with pkgs; [
      nerdfonts
    ];
  };
}