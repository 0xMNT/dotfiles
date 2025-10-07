#!/bin/bash

# Check current rotation state
STATE_FILE="/tmp/hypr_rotation_state"

if [ ! -f "$STATE_FILE" ] || [ "$(cat $STATE_FILE)" = "0" ]; then
    # Rotate to 90 degrees
    hyprctl keyword monitor eDP-1,1920x1080@60,0x0,1.25,transform,1
    hyprctl keyword device:elan900c:00-04f3:2830:transform 1
    echo "1" > "$STATE_FILE"
else
    # Rotate back to normal
    hyprctl keyword monitor eDP-1,1920x1080@60,0x0,1.25,transform,0
    hyprctl keyword device:elan900c:00-04f3:2830:transform 0
    echo "0" > "$STATE_FILE"
fi
