#!/bin/bash
# Move workspaces 2-6 to the external monitor after startup apps have opened.
# Needed because Hyprland workspace rules don't retroactively move workspaces
# that were created by startup commands before the rule could enforce placement.
sleep 2
for ws in 2 3 4 5 6; do
    hyprctl dispatch "hl.dsp.workspace.move({ workspace = \"$ws\", monitor = \"HDMI-A-1\" })"
done
