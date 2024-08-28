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

      initExtra = ''
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
        [ -f ./.p10k.zsh ] && source ./.p10k.zsh
        ${pkgs.fastfetch}/bin/fastfetch
      '';

      zplug = {
        enable = true;
        plugins = [
          {
            name = "romkatv/powerlevel10k";
            tags = [ as:theme depth:1 ];
          }
        ];
      };
    };
  };
}
