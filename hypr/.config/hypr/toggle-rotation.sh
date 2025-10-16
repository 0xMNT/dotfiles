#!/bin/bash

# Check current rotation state
STATE_FILE="/tmp/hypr_rotation_state"
CONFIG_FILE="$HOME/.config/hypr/hosts/laptop.conf"

if [ ! -f "$STATE_FILE" ] || [ "$(cat $STATE_FILE)" = "0" ]; then
    # Rotate to 90 degrees
    sed -i 's/transform,0/transform,1/; s/transform = 0/transform = 1/' "$CONFIG_FILE"
    hyprctl reload
    echo "1" > "$STATE_FILE"
else
    # Rotate back to normal
    sed -i 's/transform,1/transform,0/; s/transform = 1/transform = 0/' "$CONFIG_FILE"
    hyprctl reload
    echo "0" > "$STATE_FILE"
fi
