#!/bin/sh

# Check if HDMI-1 is connected
if xrandr | grep -q "HDMI-1 connected"; then
    # Set HDMI-1 to 1080p and turn off the laptop screen
    xrandr --output HDMI-1 --mode 1920x1080 --primary --output eDP-1 --off
else
    # Ensure laptop screen is on if HDMI is disconnected
    xrandr --output eDP-1 --auto --primary --output HDMI-1 --off
fi
