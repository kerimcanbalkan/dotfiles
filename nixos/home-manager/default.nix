{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./dotfiles.nix
    ./bash.nix
    ./emacs.nix
    ./gpg.nix
    ./nvim.nix
    ./git.nix
    ./firefox.nix
  ];

  home.username = "kerim";
  home.homeDirectory = "/home/kerim";
  home.stateVersion = "25.05";

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  programs.nix-index = {
    enable = true;
    enableBashIntegration = true;
  };
}
