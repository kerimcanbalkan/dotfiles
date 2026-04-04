#!/bin/sh

# This file should be located at ~/.dwm/autostart.sh

# Keyboard settings
xset r rate 170 90
setxkbmap -layout us,tr -option grp:alt_space_toggle &

# Display configuration
sleep 15 && autorandr --change &
dwmblocks &

# Background services
emacs --daemon &
light-locker &
redshift -O 3500 &
xwallpaper --daemon --stretch /home/kerim/Pictures/Wallpapers/gnu.jpg &
