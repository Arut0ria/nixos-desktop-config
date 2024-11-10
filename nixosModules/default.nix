{ pkgs, lib, ... }: {
  imports = [
    ./services/nvidia.nix
    ./services/pipewire.nix
    ./services/plasma.nix
    ./services/ssh.nix
    ./services/locale.nix
    ./services/dlna.nix
    ./services/virtualisation.nix

    ./programs/stylix.nix
    ./programs/steam.nix
    ./programs/retroarch.nix
    ./programs/nixvim.nix
  ];

  nvidia-module.enable = lib.mkDefault true;
  pipewire-module.enable = lib.mkDefault true;
  plasma-module.enable = lib.mkDefault true;
  ssh-module.enable = lib.mkDefault true;
  locale-module.enable = lib.mkDefault true;
  dlna-module.enable = lib.mkDefault true;

  virtualisation-service.enable = lib.mkDefault true;
  docker-service.enable = lib.mkDefault true;

  stylix-module.enable = lib.mkDefault true;
  steam-program.enable = lib.mkDefault true;
  retroarch-program.enable = lib.mkDefault true;

  nixvim-program.enable = lib.mkDefault true;
}
