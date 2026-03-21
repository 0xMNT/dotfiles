#!/bin/bash

WALLPAPER_FILE="$HOME/.config/sway/current_wallpaper"

# Wait for sway to be ready
sleep 1

if [ -f "$WALLPAPER_FILE" ]; then
    WALLPAPER=$(cat "$WALLPAPER_FILE")
    if [ -f "$WALLPAPER" ]; then
        swaymsg output '*' bg "$WALLPAPER" fill
    fi
else
    # Default wallpaper
    DEFAULT="/home/mnt/Downloads/5.png"
    if [ -f "$DEFAULT" ]; then
        swaymsg output '*' bg "$DEFAULT" fill
    fi
fi
