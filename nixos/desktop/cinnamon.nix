{ config, pkgs, ...}:

{
  services.xserver.desktopManager.cinnamon.enable = true;

  environment.systemPackages = with pkgs; [
    kitty
    dmenu
  ];
}
