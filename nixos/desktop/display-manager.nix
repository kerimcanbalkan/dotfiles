{ config, pkgs, ... }:

{
  # Enable GDM display manager (updated syntax)
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;

  # services.displayManager.gdm = {
  #   enable = true;
  #   wayland = true;
  # };
}
