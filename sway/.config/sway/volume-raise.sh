#!/bin/bash
# Unmute if muted, then raise volume

if [ -x "$HOME/.local/bin/swayosd-client" ]; then
    SWAYOSD="$HOME/.local/bin/swayosd-client"
else
    SWAYOSD="swayosd-client"
fi

MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo 1 || echo 0)

if [ "$MUTED" = "1" ]; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
fi

$SWAYOSD --output-volume raise
