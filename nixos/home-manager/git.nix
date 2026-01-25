{ config, pkgs, ... }:

{
  programs.git = {
    enable = true;
    settings.user = {
      email =  "kerimcanbalkan@gmail.com";
      name = "kerimcanbalkan";
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };
}
