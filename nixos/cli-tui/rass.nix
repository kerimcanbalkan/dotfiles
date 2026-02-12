{ pkgs, ... }:

let
  # Adjust the path to where your default.nix is
  rassumfrassum = pkgs.python3Packages.callPackage /home/kerim/nixpkgs/pkgs/rassumfrassum {};
in
{
  environment.systemPackages = with pkgs; [
    rassumfrassum
  ];
}
