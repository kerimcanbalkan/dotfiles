{ config, pkgs, ... }:
{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.gohufont
      nerd-fonts.geist-mono
      alegreya
      montserrat
    ];

    # Font configuration
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = [ "Alegreya" ];
        sansSerif = [ "Montserrat" ];
        monospace = [ "GeistMono Nerd Font" ];
      };
    };
  };
}
