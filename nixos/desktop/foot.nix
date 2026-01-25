{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    theme = "gruvbox-dark";
    settings =  {
      main = {
        font = "GeistMono Nerd Font";
        pad = "13x13";
      };
      scrollback = {
        lines = 100000;
      };
      colors = {
        alpha = 0.9;
      };
    };
  };

}
