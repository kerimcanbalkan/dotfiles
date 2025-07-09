#!/bin/sh

# Remap Caps Lock to Ctrl
setxkbmap -option ctrl:nocaps

# Remap command to alt
# Only for MAC Computers
setxkbmap -option altwin:swap_lalt_lwin

# Add turkish keyboard
setxkbmap -layout us,tr -option 'grp:win_space_toggle'

# Scale display
xrandr --output eDP1 --scale 0.5x0.5 &

# Auto mounting usb's
udiskie --automount --notify --tray &

# Set wallpaper
xwallpaper --maximize ~/Pictures/Wallpapers/paster-car.png &

# Reload the previous color scheme
wal -R &

# Run dwmblocs
dwmblocks &

exec dwm
