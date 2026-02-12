{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # File managers
    thunar
    tumbler

    # Graphics and image optimizations
    gimp3-with-plugins
    libwebp
    libavif
    mozjpeg
    oxipng
    nodePackages.svgo

    # Productivity
    libreoffice-fresh
    harper

    # System utilities
    brightnessctl
    libnotify
    xdg-utils
    gammastep
    usbutils

    imv
    mpv
    zathura
    mako
    grim
    slurp
    w3m
    vlc
    imagemagick
    lf

    # ADB tooling for android
    android-tools
  ];

}
