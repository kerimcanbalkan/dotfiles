{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    inputs.stylix.homeModules.stylix
    ./dotfiles.nix
    ./emacs.nix
    ./gpg.nix
  ];

  home.username = "balkan";
  home.homeDirectory = "/home/balkan";
  home.stateVersion = "25.05";

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  programs.nix-index = {
    enable = true;
    enableBashIntegration = true;
  };
}
