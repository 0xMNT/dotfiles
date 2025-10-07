#!/bin/bash

# Get current volume
VOLUME=$(pamixer --get-volume)
MUTED=$(pamixer --get-mute)

if [ "$MUTED" = "true" ]; then
    notify-send -u low -h string:x-canonical-private-synchronous:volume -h int:value:0 "Volume" "Muted 󰖁"
else
    notify-send -u low -h string:x-canonical-private-synchronous:volume -h int:value:$VOLUME "Volume" "${VOLUME}% 󰕾"
fi
