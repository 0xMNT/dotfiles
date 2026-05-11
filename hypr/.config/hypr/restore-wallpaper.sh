#!/bin/bash

WALLPAPER_FILE="$HOME/.config/hypr/current_wallpaper"

if [ ! -f "$WALLPAPER_FILE" ]; then exit 0; fi
WALLPAPER=$(cat "$WALLPAPER_FILE")
if [ ! -f "$WALLPAPER" ]; then exit 0; fi

# Wait for hyprpaper to be ready
sleep 1

hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper ",$WALLPAPER"
