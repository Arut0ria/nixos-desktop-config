{ system, inputs, config, lib, pkgs, pkgs-unstable, hostName, variables, ... }:
let
  inherit (import ../../config/system/packages.nix { inherit pkgs lib; }) packages;
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
  system.stateVersion = variables.stateVersion;
}
