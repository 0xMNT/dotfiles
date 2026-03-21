#!/bin/bash

WALLPAPER_FILE="$HOME/.config/hypr/current_wallpaper"
HYPRPAPER_CONF="$HOME/.config/hyprpaper/hyprpaper.conf"

if [ ! -f "$WALLPAPER_FILE" ]; then exit 0; fi
WALLPAPER=$(cat "$WALLPAPER_FILE")
if [ ! -f "$WALLPAPER" ]; then exit 0; fi

# Write a fresh hyprpaper config with the wallpaper preloaded
mkdir -p "$(dirname "$HYPRPAPER_CONF")"
cat > "$HYPRPAPER_CONF" <<EOF
preload = $WALLPAPER
wallpaper = ,$WALLPAPER
splash = false
EOF

# Restart hyprpaper so it picks up the new config
pkill hyprpaper 2>/dev/null
sleep 0.5
hyprctl dispatch exec hyprpaper
