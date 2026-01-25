{ config, pkgs, ... }:

{
  services.displayManager.ly = {
    enable = true;
    settings = {
      save = true;
    };
  };
}
