{ pkgs, lib, config, ... }: {
  options = {
    zsh-program.enable = lib.mkEnableOption "Enables zsh.";
  };

  config = lib.mkIf config.zsh-program.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
    };
  };
}
