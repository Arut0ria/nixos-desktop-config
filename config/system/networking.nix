{ hostName, ... }:
{
  networking = {
    firewall.enable = true;
    hostName = hostName;

    networkmanager.enable = true;
  };
}
