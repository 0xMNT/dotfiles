#!/bin/bash

# Get the current volume level
VOLUME=$(amixer get Master | grep -o "[0-9]*%" | head -n 1 | tr -d '%')

# Get mute status
MUTE=$(amixer get Master | grep -o "\[off\]" | head -n 1)

# Cap the volume at 100%
if [ "$VOLUME" -gt 100 ]; then
    VOLUME=90
fi

# If muted, show "Mute"
if [[ $MUTE == "[off]" ]]; then
    echo "🔇 Mute"
else
    echo "🔊 ${VOLUME}%"
fi

