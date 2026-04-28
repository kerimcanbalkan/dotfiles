#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/dotfiles/wallpapers"

# Check if directory exists
if [[ ! -d "$WALLPAPER_DIR" ]]; then
    echo "Directory not found: $WALLPAPER_DIR"
    exit 1
fi

# Find image files (adjust extensions if needed)
selection=$(find "$WALLPAPER_DIR" -maxdepth 1 -type f \( \
    -iname "*.jpg" -o \
    -iname "*.jpeg" -o \
    -iname "*.png" -o \
    -iname "*.bmp" -o \
    -iname "*.gif" \
\) -printf "%f\n" | sort | dmenu -i -p "Select wallpaper:")

# Exit if nothing selected
[[ -z "$selection" ]] && exit 0

# Set wallpaper
xwallpaper --stretch "$WALLPAPER_DIR/$selection"
