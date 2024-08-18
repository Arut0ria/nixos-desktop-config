{ pkgs, config, lib, ... }: {
  options = {
    dlna-module.enable = lib.mkEnableOption "Enables dlna service";
  };

  config = lib.mkIf config.dlna-module.enable {
    services.minidlna.enable = true;
    services.minidlna.settings = {
      friendly_name = "DLNA MEDIA";
      media_dir = [
        # "V,/run/media/theo/Data3/Video"
        "PVA,/dlna"
        # "A,/mnt/media/Songs/" #Audio files are here
      ];
      log_level = "error";
      inotify = "yes";
      wide_links = "yes";
    };

    users.users.minidlna = {
      # isNormalUser = false;
      extraGroups = [ "users" ]; # so minidlna can access the files.
    };
  };
}
