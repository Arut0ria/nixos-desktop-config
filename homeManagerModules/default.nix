{ pkgs, lib, config, ... }: {
  imports = [
    ./packages.nix

    ./programs/firefox.nix
    ./programs/zsh.nix
    ./programs/vscode.nix
    ./programs/kitty.nix
    ./programs/fastfetch.nix
    ./programs/plasma-manager.nix
    ./programs/mangohud.nix
  ];

  homePackages.enable = lib.mkDefault true;

  firefox-program.enable = lib.mkDefault true;
  zsh-program.enable = lib.mkDefault true;
  vscode-program.enable = lib.mkDefault true;
  kitty-program.enable = lib.mkDefault true;
  plasma-manager-config.enable = lib.mkDefault true;
  fastfetch-program.enable = lib.mkDefault true;
  mangohud-program.enable = lib.mkDefault true;
}
