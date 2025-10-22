echo '{"version":1}'
echo '['
first=true

while true; do
    date_formatted=$(date "+%A %B %d")     # e.g. Friday May 05
    time_formatted=$(date "+%H:%M")        # e.g. 13:45
    weather=$(curl -s "wttr.in/?format=1") # e.g. 🌦️ +15°C

    text="$weather | $date_formatted | $time_formatted"

    # Print comma after the first line
    if $first; then
        first=false
    else
        echo ','
    fi

    echo "[{\"full_text\":\"$text\"}]"

    sleep 60
done
