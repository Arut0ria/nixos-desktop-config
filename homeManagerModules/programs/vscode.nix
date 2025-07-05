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
        rust-lang.rust-analyzer
        llvm-vs-code-extensions.vscode-clangd
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "vscode-tailwindcss";
          publisher = "bradlc";
          version = "0.14.21";
          sha256 = "TRc0RAhVZuvMHqmvNnDQlj1udslvQofxYvJnv/Ftp/g=";
        }
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
        {
          name = "vscode-glsllint";
          publisher = "dtoplak";
          version = "1.9.0";
          sha256 = "sha256-Ic5yCR9CIaYylw0wPSL7lgSk+2f2O/pYkWKGKJNwm0g=";
        }
        {
          name = "glsl-literal";
          publisher = "boyswan";
          version = "1.0.6";
          sha256 = "sha256-xprVNva0UOZBiCxxhnd71L+nLbtCbYfy4v6z8x685ck=";
        }
        {
          name = "shader";
          publisher = "slevesque";
          version = "1.1.5";
          sha256 = "sha256-Pf37FeQMNlv74f7LMz9+CKscF6UjTZ7ZpcaZFKtX2ZM=";
        }
        {
          name = "vscode-conventional-commits";
          publisher = "vivaxy";
          version = "1.26.0";
          sha256 = "sha256-Lj2+rlrKm9h21zEoXwa2TeGFNKBmlQKr7MRX0zgngdg=";
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
          "glsllint.glslangValidatorPath" = "glslang";
          "nix.formatterPath" = "nixpkgs-fmt";
        };
    };
  };
}
