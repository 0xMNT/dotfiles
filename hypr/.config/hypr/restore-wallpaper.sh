#!/bin/bash

# File containing the last selected wallpaper
WALLPAPER_FILE="$HOME/.config/hypr/current_wallpaper"

# Wait a bit for hyprpaper to start
sleep 2

# Check if we have a saved wallpaper
if [ -f "$WALLPAPER_FILE" ]; then
    WALLPAPER=$(cat "$WALLPAPER_FILE")

    # Check if the wallpaper file exists
    if [ -f "$WALLPAPER" ]; then
        # Set the wallpaper
        hyprctl hyprpaper preload "$WALLPAPER"
        hyprctl hyprpaper wallpaper ",$WALLPAPER"
    fi
fi
