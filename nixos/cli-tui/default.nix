{ config, pkgs, ... }:

{
  imports = [
    ./core-utils.nix
    ./rass.nix
  ];
}
