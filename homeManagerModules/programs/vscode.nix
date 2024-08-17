{ pkgs, lib, config, ... }: {
  options = {
    vscode-program.enable = lib.mkEnableOption "Enables vscodium.";
    /*
      vscode-program.extraExtensions = lib.mkOption {
      type = with lib.types; listOf package;
      description = "List of additional VSCode extensions to install.";
      default = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        bierner.emojisense
      ];
      };
    */
  };

  config = lib.mkIf config.vscode-program.enable {
    programs.vscode = {
      enable = true;
      mutableExtensionsDir = false;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        bierner.emojisense
      ];
    };
  };
}
