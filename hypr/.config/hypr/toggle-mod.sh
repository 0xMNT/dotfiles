#!/bin/bash
# Toggle mainMod between ALT and SUPER in vars.lua, then reload hyprland
CONFIG="$HOME/.config/hypr/vars.lua"

if grep -q 'mainMod *= *"ALT"' "$CONFIG"; then
    sed -i 's/mainMod\( *\)= *"ALT"/mainMod\1= "SUPER"/' "$CONFIG"
    notify-send "Hyprland" "Mod key: SUPER (Win)"
else
    sed -i 's/mainMod\( *\)= *"SUPER"/mainMod\1= "ALT"/' "$CONFIG"
    notify-send "Hyprland" "Mod key: ALT"
fi

hyprctl reload
