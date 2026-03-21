#!/bin/bash
# Move workspaces 2-6 to the external monitor after startup apps have opened.
# Needed because Hyprland workspace rules don't retroactively move workspaces
# that were created by exec-once commands before the rule could enforce placement.
sleep 2
hyprctl --batch "dispatch moveworkspacetomonitor 2 HDMI-A-1 ; \
                 dispatch moveworkspacetomonitor 3 HDMI-A-1 ; \
                 dispatch moveworkspacetomonitor 4 HDMI-A-1 ; \
                 dispatch moveworkspacetomonitor 5 HDMI-A-1 ; \
                 dispatch moveworkspacetomonitor 6 HDMI-A-1"
