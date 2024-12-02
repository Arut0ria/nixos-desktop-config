{ pkgs, lib, config, ... }:
let
  get-a-gal = import ./get-a-gal.nix { inherit pkgs; };
  pattern = "*Maid*";
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

        char_pixel_size=20
        fastfetch_number_of_line=19

        alias fs='height=$((fastfetch_number_of_line * char_pixel_size))
        IMAGE_PATH="$(${pkgs.python3}/bin/python ${get-a-gal}/bin/main.py --pattern "${pattern}" ${get-a-gal}/images)"
        TEMP_IMAGE="$(mktemp)"
        ${pkgs.imagemagick}/bin/magick "$IMAGE_PATH" -resize "x$height" "$TEMP_IMAGE" \
        && ${pkgs.fastfetch}/bin/fastfetch --kitty-direct "$TEMP_IMAGE" \
        && rm $TEMP_IMAGE'

        # height=$((fastfetch_number_of_line * char_pixel_size))
        # IMAGE_PATH="$(${pkgs.python3}/bin/python ${get-a-gal}/bin/main.py --pattern "${pattern}" ${get-a-gal}/images)"
        # TEMP_IMAGE="$(mktemp)"
        # magick "$IMAGE_PATH" -resize "x$height" "$TEMP_IMAGE" \
        # && ${pkgs.fastfetch}/bin/fastfetch --kitty-direct "$TEMP_IMAGE" \
        # && rm $TEMP_IMAGE

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
