#!/bin/bash

PATH_DIR="/sys/class/backlight/intel_backlight"
MAX=$(cat "$PATH_DIR/max_brightness")
CURR=$(cat "$PATH_DIR/brightness")
STEP=$(( MAX / 10 )) # 10% step size

# Default to 'get' if no argument is provided
ACTION="${1:-get}"

case "$ACTION" in
    get)
        awk "BEGIN {printf \"%.0f%%\n\", ($CURR/$MAX)*100}"
        ;;
    inc|up)
        NEW=$(( CURR + STEP ))
        [ "$NEW" -gt "$MAX" ] && NEW="$MAX"
        echo "$NEW" | doas tee "$PATH_DIR/brightness" > /dev/null
        ;;
    dec|down)
        MIN=$(( MAX / 50 )) # ~2% minimum to prevent a black screen
        NEW=$(( CURR - STEP ))
        [ "$NEW" -lt "$MIN" ] && NEW="$MIN"
        echo "$NEW" | doas tee "$PATH_DIR/brightness" > /dev/null
        ;;
    *)
        echo "Usage: $0 [inc|dec|get]"
        exit 1
        ;;
esac
