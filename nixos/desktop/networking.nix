{ config, pkgs, ...}:

{
  networking.hostName = "balkan";

  # Enable networking
  networking.networkmanager.enable = true;

  # Disable NetworkManager's internal DNS resolution
  networking.networkmanager.dns = "none";

  # Disable firewall
  networking.firewall.enable = false;

  # These options are unnecessary when managing DNS ourselves
  networking.useDHCP = false;
  networking.dhcpcd.enable = false;
  networking.enableIPv6 = false;

  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
    "8.8.8.8"
    "8.8.4.4"
  ];

}
