{ config, pkgs, ... }:

{
  imports = [
    ./base.nix
    ./web.nix
    ./nix.nix
    ./go.nix
    ./lua.nix
  ];
}
