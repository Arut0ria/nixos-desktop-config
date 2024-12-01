{ pkgs, config, lib, ... }:
{
  imports = [
    ./boot.nix
    ./networking.nix
    ./nix-settings.nix
    ./user-settings.nix
    ./hardware.nix
  ];
}
