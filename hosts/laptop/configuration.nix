{ system, inputs, config, lib, pkgs, pkgs-unstable, hostName, ... }:
let
  inherit (import ../../config/system/packages.nix { inherit pkgs lib; }) packages;
  inherit (import ../../config/variables.nix) stateVersion;
in
{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.home-manager

      ../../config/home/default.nix
      ../../config/system/default.nix
    ];

  /**
    Adding packages
  */
  environment.systemPackages = packages;

  /**
    Misc config
  */
  security.polkit.enable = true;
  system.stateVersion = stateVersion;
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
}

