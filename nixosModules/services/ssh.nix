{ pkgs, lib, config, ... }: {
  options = {
    ssh-module.enable = lib.mkEnableOption "Enables openssh.";
  };

  config = lib.mkIf config.ssh-module.enable {
    services = {
      openssh.enable = true;
    };

    programs = {
      ssh.startAgent = true;
    };
  };
}
