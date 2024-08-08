{ pkgs, lib, config, ... }: {
  options = {
    vscode-program.enable = lib.mkEnableOption "Enables vscodium.";
  };

  config = lib.mkIf config.vscode-program.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
      ];
    };
  };
}
