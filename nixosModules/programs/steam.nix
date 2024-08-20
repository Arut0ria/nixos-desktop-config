{ pkgs, config, lib, ... }: {
  options = {
    steam-program.enable = lib.mkEnableOption "Enables steam";
  };

  config = lib.mkIf config.steam-program.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [
      protonup
      bottles
    ];

    # No need for this I think...
    # environment.sessionVariables = {
    #   STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    # };
  };
}
