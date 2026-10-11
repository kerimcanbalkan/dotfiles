# Keyboard settings
xset r rate 170 90 &
setxkbmap -layout us,tr -option grp:alt_space_toggle
setxkbmap -option ctrl:nocaps
xset s off
xset s noblank
xset -dpms

# Desktop
redshift -O 4000 &
xwallpaper --daemon --stretch /home/kerim/dotfiles/wallpapers/island-house.jpg &
xautolock -cornersize 30 -corners ---- -cornersize 30 -time 10 -notify 10 -notifier ~/dotfiles/scripts/notify-lock.sh -locker slock &
slstatus &
xcompmgr -c &
unclutter &


# Configure displays
./dotfiles/scripts/display-toggle.sh


# Start dbus session
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

# Notification daemon
dunst &

exec dwm
