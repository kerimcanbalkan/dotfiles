#!/bin/sh

# Check if any application is outputting audio (works with PipeWire/Pulse)
if pactl list sink-inputs | grep -q "state: RUNNING"; then
    exit 0
fi

# Check if the active window is full screen (requires xprop)
# This covers browsers and video players
IS_FULLSCREEN=$(xprop -id $(xprop -root _NET_ACTIVE_WINDOW | cut -d ' ' -f 5) _NET_WM_STATE | grep -c "_NET_WM_STATE_FULLSCREEN")

if [ "$IS_FULLSCREEN" -eq 0 ]; then
    xscreensaver-command -lock
fi
