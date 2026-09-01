xrandr --dpi 96		# Set DPI. User may want to use a larger number for larger screens.
# # Keyboard settings
xset r rate 170 90 &
setxkbmap -layout us,tr -option grp:alt_space_toggle
setxkbmap -option ctrl:nocaps

# # # Background services
emacs --daemon &
dunst &

# # # Desktop
redshift -O 3500 &
xwallpaper --daemon --stretch /home/kerim/dotfiles/wallpapers/island-house.jpg &
xautolock -cornersize 30 -corners ---- -cornersize 30 -time 10 -notify 10 -notifier ~/dotfiles/scripts/notify-lock.sh -locker slock &
slstatus &
xcompmgr -c &
unclutter &

# # Configure displays
./dotfiles/scripts/display-toggle.sh

dbus-update-activation-environment --all
dbus-launch dwm
# ./dotfiles/scripts/start-exwm.sh
