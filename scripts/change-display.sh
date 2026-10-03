#!/usr/bin/env bash

# Ask Action
action=$(printf "Internal\nExternal\nBoth" | dmenu -p "Action:")

# Exit if cancelled
[ -z "$action" ] && exit 1

if [ "$action" = "Internal" ]; then
    # Only enable laptop monitor
    xrandr --output eDP1 --auto --primary --output HDMI1 --off
elif [ "$action" = "External" ]; then
    xrandr --output HDMI1 --mode 1920x1080 --primary --output eDP1 --off
elif [ "$action" = "Both" ]; then
    xrandr --output eDP1 --auto --primary --output HDMI1 --mode 1920x1080
fi
