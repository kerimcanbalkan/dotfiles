{ config, pkgs, ... }:

{
  imports = [
    ./applications.nix
    ./audio.nix
    ./bluetooth.nix
    ./boot.nix
    ./browsers.nix
    ./communication.nix
    ./display-manager.nix
    ./fonts.nix
    ./foot.nix
    ./gaming.nix
    #    ./hyprland.nix
    ./cinnamon.nix
    ./theming.nix
    ./networking.nix
    ./power.nix
    ./email.nix
    ./printing.nix
  ];
}
