{ pkgs, lib, config, ... }: {
  options = {
    vscode-program.enable = lib.mkEnableOption "Enables vscodium.";
  };

  config = lib.mkIf config.vscode-program.enable {
    programs.vscode = {
      enable = true;
      mutableExtensionsDir = false;
      package = pkgs.vscodium;
      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        arrterian.nix-env-selector
        ms-python.python
        angular.ng-template
      ];

      userSettings =
        let
          stylix-monospace = if (config.stylix.enable) then (config.stylix.fonts.monospace.name) else ("");
          nerd-font = "Hack Nerd Font";
        in
        {
          "editor.fontFamily" = lib.mkForce "'${stylix-monospace}', '${nerd-font}'";
          "terminal.integrated.fontFamily" = lib.mkForce "";
        };
    };
  };
}
