{ pkgs, ... }:
let
  inherit (import ../variables.nix) userName homeDir stateVersion;
  inherit (import ./packages.nix { inherit pkgs; }) packages;
in
{
  home = {
    username = userName;
    homeDirectory = homeDir;
    stateVersion = stateVersion;

    packages = [ ] ++ packages;
    file = { };
    sessionVariables = { };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
