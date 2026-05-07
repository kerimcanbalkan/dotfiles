#!/usr/bin/env sh

# Generate a timestamp
timestamp=$(date +'%Y-%m-%d-%H%M%S')
filename="${timestamp}_screenshot.png"

# Take a screenshot of a selected region, save it to a file, and copy to clipboard
grim -g "$(slurp)" - | tee ~/Pictures/Screenshots/"${filename}" | xclip

# Send a notification
notify-send "Screenshot" "${filename} saved to screenshots directory."
