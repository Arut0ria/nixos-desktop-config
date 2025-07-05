{ config, lib, pkgs, ... }@args: {
  options = {
    cava-program.enable = lib.mkEnableOption "Enables cava.";
  };

  config = lib.mkIf config.cava-program.enable {
    stylix.targets.cava.rainbow.enable = lib.mkIf (builtins.hasAttr "stylix" args.inputs) true;

    programs.cava = {
      enable = true;
    };
  };
}
