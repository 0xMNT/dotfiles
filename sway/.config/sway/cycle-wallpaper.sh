#!/bin/bash

WALLPAPER_DIR="$HOME/Pictures"
STATE_FILE="$HOME/.config/sway/current_wallpaper_index"
WALLPAPER_FILE="$HOME/.config/sway/current_wallpaper"

mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | sort)

if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    notify-send "Wallpaper Cycler" "No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

if [ -f "$STATE_FILE" ]; then
    CURRENT_INDEX=$(cat "$STATE_FILE")
    if ! [[ "$CURRENT_INDEX" =~ ^[0-9]+$ ]]; then
        CURRENT_INDEX=-1
    fi
else
    CURRENT_INDEX=-1
fi

CURRENT_INDEX=$(( (CURRENT_INDEX + 1) % ${#WALLPAPERS[@]} ))
WALLPAPER="${WALLPAPERS[$CURRENT_INDEX]}"

echo "$CURRENT_INDEX" > "$STATE_FILE"
echo "$WALLPAPER" > "$WALLPAPER_FILE"

if [ ! -f "$WALLPAPER" ]; then
    notify-send "Wallpaper Cycler" "Error: Wallpaper file not found"
    exit 1
fi

swaymsg output '*' bg "$WALLPAPER" fill

WALLPAPER_NAME=$(basename "$WALLPAPER")
notify-send "Wallpaper Changed" "$WALLPAPER_NAME ($((CURRENT_INDEX + 1))/${#WALLPAPERS[@]})" -t 2000
