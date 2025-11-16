#!/bin/bash
# Unmute if muted, then raise volume

# Use custom swayosd if available, otherwise system version
if [ -x "$HOME/.local/bin/swayosd-client" ]; then
    SWAYOSD="$HOME/.local/bin/swayosd-client"
else
    SWAYOSD="swayosd-client"
fi

# Check if muted (1 = muted, 0 = unmuted)
MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo 1 || echo 0)

# If muted, unmute first
if [ "$MUTED" = "1" ]; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
fi

# Raise volume
$SWAYOSD --output-volume raise
