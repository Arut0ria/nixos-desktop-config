{ pkgs, lib, config, ...} : {
  options = {
    kitty-program.enable = lib.mkEnableOption "Enables kitty.";
  };

  config = lib.mkIf config.kitty-program.enable {
    programs.kitty = {
      enable = true;
      shellIntegration.enableZshIntegration = (lib.mkIf (config.zsh-program.enable) true);
    };
  };
}