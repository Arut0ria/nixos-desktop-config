{ pkgs, lib, ... }: {
  imports = [
    ./services/nvidia.nix
    ./services/pipewire.nix
    ./sercices/plasma.nix
    ./services/ssh.nix
    ./services/locale.nix

    ./programs/stylix.nix
  ];

  nvidia-module.enable = lib.mkDefault true;
  pipewire-module.enable = lib.mkDefault true;
  plasma-module.enable = lib.mkDefault true;
  ssh-module.enable = lib.mkDefault true;
  locale-module.enable = lib.mkDefault true;

  stylix-module.enable = lib.mkDefault true;
}
