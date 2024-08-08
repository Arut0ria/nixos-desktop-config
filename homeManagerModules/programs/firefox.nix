{ pkgs, lib, config, ... }: {
  options = {
    firefox-program.enable = lib.mkEnableOption "Enables firefox.";
  };

  config = lib.mkIf config.firefox-program.enable {
    programs.firefox = {
      enable = true;
      languagePacks = [
        "fr"
      ];
    };
  };
}
