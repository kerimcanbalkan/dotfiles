#!/bin/sh

# Keyboard settings
xset r rate 170 90
setxkbmap -layout us,tr -option grp:alt_space_toggle &

slstatus &

# Background services
emacs --daemon &
light-locker &
redshift -O 3500 &
systemctl start hotplug-monitor &
xwallpaper --daemon --stretch /home/kerim/Pictures/Wallpapers/venternal.jpg &

# Start VPN
# mullvad connect &
