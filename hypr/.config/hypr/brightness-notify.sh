#!/bin/bash

# Get current brightness
MAX_BRIGHTNESS=$(brightnessctl max)
CURRENT_BRIGHTNESS=$(brightnessctl get)
BRIGHTNESS_PERCENT=$((CURRENT_BRIGHTNESS * 100 / MAX_BRIGHTNESS))

dunstify -u low -r 2593 -h int:value:$BRIGHTNESS_PERCENT -h string:hlcolor:#98FFB3 "Brightness" "${BRIGHTNESS_PERCENT}% 󰃠"
