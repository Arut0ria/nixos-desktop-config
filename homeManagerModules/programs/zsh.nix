{ inputs, pkgs, lib, config, ... }:
let 
  /**
    To be generic use : pt * 1.333
    Else : pt * (DPI / 72)
    Current good size = 432, ratio of 1.999, need to get DPI properly
  */
  dpi = 96 * 1.25; # Laptop is 96
  char_pixel_size = toString (config.stylix.fonts.sizes.terminal * (dpi / 72.0));
  getagal = config.programs.getagal.package;
  pattern = "(?i).*(middle|close).*\.(jpe?g|png|gif|bmp|webp)$";
in
{
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
        [ -f ~/.p10k.zsh ] && source ~/.p10k.zsh

        char_pixel_size=${char_pixel_size}
        fastfetch_number_of_line=18
        image_height=$(printf %.0f $((fastfetch_number_of_line * char_pixel_size)))

        pattern_file="$HOME/.config/getagal/pattern"
        mkdir -p "$(dirname "$pattern_file")"
        [ ! -f "$pattern_file" ] && echo "${pattern}" > "$pattern_file"

        pattern=$(<~/.config/getagal/pattern)
        alias fs='${pkgs.fastfetch}/bin/fastfetch --kitty-direct $(${getagal}/bin/getagal -s ${getagal}/share/images -n $image_height -p "$pattern")'
 
        fs # Runnings fastfetch
      '';

      oh-my-zsh = {
        enable = true;
        plugins = lib.mkMerge [
          [ "git" ]
          [ "docker" ]
          # (lib.mkIf (config.docker-service.enable) ["docker"])
        ];
      };

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