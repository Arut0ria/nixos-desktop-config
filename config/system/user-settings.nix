{ pkgs, lib, config, variables, ... }:
{
  users.users = {
    "${variables.userName}" = {
      isNormalUser = true;
      extraGroups = lib.mkMerge [
        ([ "wheel" ])
        (lib.mkIf (config.docker-service.enable) [ "docker" ])
        (lib.mkIf (config.virtualisation-service.enable) [ "libvirtd" ])
      ];

      packages = with pkgs; [ ];
      shell = pkgs.zsh;
      # ignoreShellProgramCheck = true;
    };
  };
}
