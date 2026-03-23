#!/bin/bash
# Toggle $mainMod between ALT and SUPER in common.conf, then reload hyprland
CONFIG="$HOME/.config/hypr/hosts/common.conf"

current=$(grep '^\$mainMod = ' "$CONFIG" | awk '{print $3}')

if [ "$current" = "ALT" ]; then
    sed -i 's/^\$mainMod = ALT/$mainMod = SUPER/' "$CONFIG"
    notify-send "Hyprland" "Mod key: SUPER (Win)"
else
    sed -i 's/^\$mainMod = SUPER/$mainMod = ALT/' "$CONFIG"
    notify-send "Hyprland" "Mod key: ALT"
fi

hyprctl reload
