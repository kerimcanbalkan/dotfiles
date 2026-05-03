#!/bin/sh

echo '{"version":1}'
echo '['

while true; do
    # 1. Temperature (Converted from millidegrees to degrees)
    temp_raw=$(cat /sys/class/thermal/thermal_zone8/temp)
    temp=$((temp_raw / 1000))

    # 2. RAM Percentage
    ram_perc=$(free | grep Mem | awk '{print int($3/$2 * 100)}')

    # 3. Battery Percentage and State
    bat_path="/sys/class/power_supply/BAT0"
    bat_perc=$(cat "$bat_path/capacity")
    bat_state=$(cat "$bat_path/status") # e.g., Charging, Discharging

    # 4. Volume (using pactl)
    vol=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '/Volume/ {print $5}')

    # 5. Date and Time (Matching %H:%M:%S | %d.%m.%Y)
    datetime=$(date "+%H:%M:%S | %d.%m.%Y")

    # Format the full text string to match slstatus output
    # Format: TEMP: 45°C | RAM: 12% | BAT: 95% [Discharging] | VOL: 50% | 14:00:00 | 01.01.2024
    text="TEMP: ${temp}°C | RAM: ${ram_perc}% | BAT: ${bat_perc}% [${bat_state}] | VOL: ${vol} | ${datetime}"

    # Output as a JSON array for Sway
    echo "[{\"full_text\":\"$text\"}],"

    sleep 1
done
