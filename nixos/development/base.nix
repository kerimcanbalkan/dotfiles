{ config, lib, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
    glibc
    clang
    cmake
    libtool
    gnumake
    sdbus-cpp
    pciutils
    lspmux # Lsp multiplexer
  ];
}
