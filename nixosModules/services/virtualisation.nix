{ pkgs, config, lib, ... }: {
  options = {
    virtualisation-service.enable = lib.mkEnableOption "Enable KVM and all";
    docker-service.enable = lib.mkEnableOption "Enables Docker";
  };

  config = {
    /*
      Qemu and docker packages
    */
    environment.systemPackages = lib.mkMerge [
      (with pkgs; [ qemu quickemu ])
      (lib.mkIf (config.docker-service.enable) (with pkgs; [ docker ]))
    ];

    /*
      Docker
    */
    virtualisation.docker = lib.mkIf (config.docker-service.enable) {
      enable = true;
      storageDriver = "btrfs";
    };


    /*
      LibVirt setup
    */
    virtualisation.libvirtd = lib.mkIf config.virtualisation-service.enable {
      enable = true;
    };

    programs.virt-manager = lib.mkIf config.virtualisation-service.enable {
      enable = true;
    };
  };
}
