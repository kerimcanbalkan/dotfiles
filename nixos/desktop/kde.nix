{ config, pkgs, ... }:

{
  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = with pkgs; [
    kdePackages.elisa
    kdePackages.kdepim-runtime
    kdePackages.kmahjongg
    kdePackages.kmines
    kdePackages.konversation
    kdePackages.kpat
    kdePackages.ksudoku
    kdePackages.ktorrent
    kdePackages.powerdevil
    kdePackages.baloo
    kdePackages.plasma-browser-integration
    kdePackages.plasma-disks
    kdePackages.plasma-pa
    kdePackages.print-manager
    kdePackages.discover
    kdePackages.kactivitymanagerd
    kdePackages.kdepim-runtime
    kdePackages.kwalletmanager
    kdePackages.kwallet-pam
    mpv
  ];

  environment.sessionVariables = {
    BALOO_ENABLED = "false";
    KWIN_X11_NO_SYNC_TO_VBLANK = "1";
    KWIN_TRIPLE_BUFFER = "1";
  };

  services.power-profiles-daemon.enable = false;
  services.tlp.enable = false;
}
