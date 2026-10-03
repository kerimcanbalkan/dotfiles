#!/bin/sh

# Check if HDMI-1 is connected
if xrandr | grep -q "HDMI1 connected"; then
    # Set HDMI-1 to 1080p and turn off the laptop screen
    xrandr --output HDMI1 --mode 1920x1080 --primary --output eDP1 --off
else
    # Ensure laptop screen is on if HDMI is disconnected
    xrandr --output eDP1 --auto --primary --output HDMI1 --off
fi
