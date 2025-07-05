{ pkgs, lib, config, ... }: {
  options = {
    getagal-program.enable = lib.mkEnableOption "Enables getagal program.";
  };

  config = lib.mkIf config.getagal-program.enable {
    programs.getagal = {
      enable = true;
    };
  };
}
