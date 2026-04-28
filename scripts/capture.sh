#!/usr/bin/env bash

dir="$HOME/pictures/screenshots"
mkdir -p "$dir"

# Ask action
action=$(printf "Save\nCopy" | dmenu -p "Action:")

# Exit if cancelled
[ -z "$action" ] && exit 1

if [ "$action" = "Save" ]; then
    # Default filename with timestamp
    default_name="screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

    filename=$(printf "%s" "$default_name" | dmenu -p "Save as:")
    [ -z "$filename" ] && exit 1

    filepath="$dir/$filename"

    if [ -e "$filepath" ]; then
        notify-send "File exists" "Won't overwrite: $filepath"
        exit 1
    fi

    # -s allows interactive selection with the mouse
    maim -s "$filepath" && notify-send "Saved" "Screenshot saved to $filepath"

elif [ "$action" = "Copy" ]; then
    # Copy to clipboard (requires xclip)
    # -s for selection, then pipe output directly to xclip
    maim -s | xclip -selection clipboard -t image/png && \
    notify-send "Copied" "Screenshot copied to clipboard"
fi
