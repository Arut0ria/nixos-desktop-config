{ pkgs, lib, variables, ... }:
let
  inherit (import ./packages.nix { inherit pkgs; }) packages;
in
{
  home = {
    username = variables.userName;
    homeDirectory = variables.homeDir;
    stateVersion = variables.stateVersion;

    packages = [ ] ++ packages;
    file = { };
    sessionVariables = { };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
