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
  security.polkit.enable = true;
  system.stateVersion = variables.stateVersion;
  programs.zsh.enable = true;
  nixpkgs.config.allowUnfree = true;

  /**
    Intel graphics for laptop config
  */
  hardware.opengl = {
    enable = true;
  };

  /**
    Overrides
  */
  nvidia-module.enable = lib.mkForce false;
  dlna-module.enable = lib.mkForce false;
  # steam-program.enable = lib.mkForce false;
  retroarch-program.enable = lib.mkForce false;
  virtualisation-service.enable = lib.mkForce false;

  stylix-application-fontSize = 10;

  /**
    Home manager overrides
  */
  home-manager.users.${variables.userName} = {
    plasmusic-displaycontrols = false;
    plasmusic-maxWidth = 150;
  };
}

