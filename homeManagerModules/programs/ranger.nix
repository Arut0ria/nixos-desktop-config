{ pkgs, config, lib, ... }: {
  options = {
    ranger-program.enable = lib.mkEnableOption "Enables Ranger";
  };

  config = lib.mkIf config.ranger-program.enable {
    programs.ranger = {
      enable = true;
      settings = {
        preview_images_method = lib.optionals (config.kitty-program.enable) "kitty";
      };
    };
  };
}
