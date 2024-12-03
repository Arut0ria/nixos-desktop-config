{ system, inputs, config, lib, pkgs, pkgs-unstable, hostName, ... }:
let
  inherit (import ../../config/system/packages.nix { inherit pkgs lib; }) packages;
  inherit (import ../../config/variables.nix { inherit lib; }) stateVersion;
in
{
  imports =
    [
      ./hardware-configuration.nix
    ];

  /**
    Adding packages
  */
  environment.systemPackages = packages;

  /**
    Misc config
  */
  programs.zsh.enable = true;
  nixpkgs.config.allowUnfree = true;
  security.polkit.enable = true;
  system.stateVersion = stateVersion;
}
