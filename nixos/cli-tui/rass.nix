{ pkgs, ... }:

let
  rassumfrassum = pkgs.python3Packages.callPackage /etc/nixos/pkgs/rassumfrassum {};
in {
  environment.systemPackages = with pkgs; [
    rassumfrassum
  ];
}
