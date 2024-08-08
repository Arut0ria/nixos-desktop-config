{ pkgs, lib, ... }: {
  imports = [
    ./programs/firefox.nix
    ./programs/zsh.nix
    ./programs/vscode.nix
  ];

  firefox-program.enable = lib.mkDefault true;
  zsh-program.enable = lib.mkDefault true;
  vscode-program.enable = lib.mkDefault true;
}
