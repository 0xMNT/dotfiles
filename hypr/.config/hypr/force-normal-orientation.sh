#!/bin/bash
# Force normal orientation on startup
hyprctl keyword monitor eDP-1,1920x1080@60,0x0,1.25,transform,0
hyprctl keyword device:elan900c:00-04f3:2830:transform 0
echo 0 > /tmp/hypr_rotation_state
