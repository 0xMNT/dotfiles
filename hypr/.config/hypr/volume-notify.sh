#!/bin/bash

# Get current volume
VOLUME=$(pamixer --get-volume)
MUTED=$(pamixer --get-mute)

if [ "$MUTED" = "true" ]; then
    dunstify -u low -r 2592 -h int:value:0 "Volume" "Muted 󰖁"
else
    dunstify -u low -r 2592 -h int:value:$VOLUME "Volume" "${VOLUME}% 󰕾"
fi
