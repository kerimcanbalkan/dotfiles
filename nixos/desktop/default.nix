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
    ./email.nix
    ./fonts.nix
    ./foot.nix
    ./gaming.nix
    ./hyprland.nix
    ./networking.nix
    ./power.nix
    ./printing.nix
  ];
}
