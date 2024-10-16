#!/bin/bash

# Function to cap the volume at 100%
set_volume() {
    local volume=$1
    # Set the volume, making sure it's capped at 100%
    if [ "$volume" -gt 100 ]; then
        volume=100
    fi
    pactl set-sink-volume @DEFAULT_SINK@ "$volume%"
}

# Determine the action
case "$1" in
    raise)
        current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]\+%' | head -n 1 | tr -d '%')
        new_volume=$((current_volume + 10))
        set_volume $new_volume
        ;;
    lower)
        current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]\+%' | head -n 1 | tr -d '%')
        new_volume=$((current_volume - 10))
        # Ensure we don't go below 0%
        if [ "$new_volume" -lt 0 ]; then
            new_volume=0
        fi
        set_volume $new_volume
        ;;
    mute)
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        ;;
    *)
        echo "Usage: $0 {raise|lower|mute}"
        exit 1
        ;;
esac

# Refresh i3blocks (if you're using i3blocks)
~/.config/i3blocks/refresh_i3blocks

