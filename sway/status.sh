echo '{"version":1}'
echo '['

while true; do
    battery_path="/sys/class/power_supply/BAT0/"
    capacity=$(cat "$battery_path/capacity")
    battery="${capacity}%"
    weather=$(curl -s "wttr.in/?format=1") # e.g. 🌦️ +15°C
    date_formatted=$(date "+%A %B %d")     # e.g. Friday May 05
    time_formatted=$(date "+%H:%M")        # e.g. 13:45
    
    text="$battery | $weather | $date_formatted | $time_formatted"

    echo "[{\"full_text\":\"$text\"}]"

    sleep 60
done
