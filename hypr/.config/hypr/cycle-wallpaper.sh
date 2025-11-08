#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/Pictures"

# File to store current wallpaper index and path
STATE_FILE="$HOME/.config/hypr/current_wallpaper_index"
WALLPAPER_FILE="$HOME/.config/hypr/current_wallpaper"

# Get all image files from the wallpaper directory
mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | sort)

# Check if we found any wallpapers
if [ ${#WALLPAPERS[@]} -eq 0 ]; then
    notify-send "Wallpaper Cycler" "No wallpapers found in $WALLPAPER_DIR"
    exit 1
fi

# Get current index or start at -1 (so first increment goes to 0)
if [ -f "$STATE_FILE" ]; then
    CURRENT_INDEX=$(cat "$STATE_FILE")
    # Validate that index is a number
    if ! [[ "$CURRENT_INDEX" =~ ^[0-9]+$ ]]; then
        CURRENT_INDEX=-1
    fi
else
    CURRENT_INDEX=-1
fi

# Increment index and wrap around to 0 if we exceed array length
CURRENT_INDEX=$(( (CURRENT_INDEX + 1) % ${#WALLPAPERS[@]} ))

# Get the wallpaper path
WALLPAPER="${WALLPAPERS[$CURRENT_INDEX]}"

# Save new index and wallpaper path for persistence
echo "$CURRENT_INDEX" > "$STATE_FILE"
echo "$WALLPAPER" > "$WALLPAPER_FILE"

# Check if wallpaper file exists
if [ ! -f "$WALLPAPER" ]; then
    notify-send "Wallpaper Cycler" "Error: Wallpaper file not found"
    exit 1
fi

# Get wallpaper filename for notification
WALLPAPER_NAME=$(basename "$WALLPAPER")

# Unload all current wallpapers to free memory
hyprctl hyprpaper unload all 2>/dev/null

# Preload and set the new wallpaper
hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper ",$WALLPAPER"

# Send notification with current position
notify-send "Wallpaper Changed" "$WALLPAPER_NAME ($((CURRENT_INDEX + 1))/${#WALLPAPERS[@]})" -t 2000
