#!/usr/bin/env bash

set -euo pipefail

# icons copied from waybar config to keep visuals consistent
icons=(󰁺 󰁻 󰁼 󰁽 󰁾 󰁿 󰂀 󰂁 󰂂 󰁹)

battery_dir=""
for candidate in /sys/class/power_supply/BAT*; do
    [[ -r "$candidate/capacity" ]] || continue
    battery_dir="$candidate"
    break
done

if [[ -z "${battery_dir:-}" ]]; then
    echo "󰂑 --"
    exit 0
fi

capacity=$(cat "$battery_dir/capacity" 2>/dev/null || echo "0")
if ! [[ "$capacity" =~ ^[0-9]+$ ]]; then
    echo "󰂑 --"
    exit 0
fi

idx=$((capacity / 10))
(( idx > 9 )) && idx=9

icon="${icons[idx]}"
printf "%s%% %s\n" "$capacity" "$icon"
