#!/bin/bash

# Get hostname
HOST_NAME=$(cat /etc/hostname)

# Merge common and host-specific configs
jq -s '.[0] * .[1]' \
  ~/.config/waybar/hosts/common.jsonc \
  ~/.config/waybar/hosts/${HOST_NAME}.jsonc \
  > ~/.config/waybar/config.jsonc

echo "Waybar config merged for host: ${HOST_NAME}"
