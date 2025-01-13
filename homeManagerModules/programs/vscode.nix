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
        bradlc.vscode-tailwindcss
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "ng-template";
          publisher = "angular";
          version = "19.0.3";
          sha256 = "0bnka51qj45r504isx47zvp20761i5qk232cc069r3ws6k1xfns1";
        }
        {
          name = "render-crlf";
          publisher = "medo64";
          version = "1.8.5";
          sha256 = "um9nAMECwf1vO5ASG9KbFTN6fFDWAW/3HdDvhqbO3WQ=";
        }
      ];

      userSettings =
        let
          stylix-monospace = if (config.stylix.enable) then (config.stylix.fonts.monospace.name) else ("");
          nerd-font = "Hack Nerd Font";
        in
        {
          "editor.fontFamily" = lib.mkForce "'${stylix-monospace}', '${nerd-font}'";
          "terminal.integrated.fontFamily" = lib.mkForce "";
          "editor.tabSize" = 2;
        };
    };
  };
}
