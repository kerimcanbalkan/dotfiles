# Keyboard settings
xset r rate 170 90 &
setxkbmap -layout us,tr -option grp:alt_space_toggle
setxkbmap -option ctrl:nocaps

# Background services
emacs --daemon &


# Desktop
xwallpaper --daemon --stretch /home/kerim/dotfiles/wallpapers/gnu.jpg &
slstatus &
dunst &
xscreensaver &
redshift -O 3500 &

# Start PulseAudio
pulseaudio --start &

# Configure displays
./dotfiles/scripts/display-toggle.sh

exec dwm
