{ config, pkgs, ... }:
{
  # System-level browser installations
  environment.systemPackages = with pkgs; [
    #librewolf-unwrapped # takes 1 day to compile and fails
    brave
  ];
}
