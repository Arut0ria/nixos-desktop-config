{ system, pkgs, pkgs-unstable, config, lib, ... }@args:
{
  options = {
    steam-program.enable = lib.mkEnableOption "Enables steam";
  };

  config = lib.mkIf config.steam-program.enable
    {
      programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
      };

      programs.gamemode.enable = true;

      # nixpkgs.overlays = [
      #   (final: prev: {
      #     lutris = (import args.nixpkgs-unstable { config.allowUnfree = true; system = final.system; }).lutris;
      #   })
      # ];

      environment.systemPackages = with pkgs; [
        protonup
        bottles
        heroic
      ];
      # ++ (with pkgs-unstable; [
      #   lutris
      # ]);

      # No need for this I think...
      # environment.sessionVariables = {
      #   STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      # };
    };
}
