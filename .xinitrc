# # Keyboard settings
xset r rate 170 90 &
setxkbmap -layout us,tr -option grp:alt_space_toggle
setxkbmap -option ctrl:nocaps

# # # Background services
emacs --daemon &

# # # Desktop
redshift -O 3500 &
xwallpaper --daemon --stretch /home/kerim/dotfiles/wallpapers/space.jpg &
slstatus &
dunst &
# xscreensaver &

# Ensure D-Bus is running
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
  eval $(dbus-launch --sh-syntax --exit-with-session)
fi

# Set the runtime directory
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

# # Start PulseAudio
pulseaudio --start &

# # Configure displays
./dotfiles/scripts/display-toggle.sh
./dotfiles/scripts/idle-check.sh

exec dwm
