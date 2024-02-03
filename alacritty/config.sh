#!/bin/bash 
DIRECTORY="/home/isvvc/.config/alacritty/themes/themes"

# Find files in the directory, shuffle them, and get the first one
theme=$(ls "$DIRECTORY" | shuf -n 1)
echo "
font:
  size: 16.5
  normal:
    family: JetBrainsMonoNerdFontMono

window:
  startup_mode: Fullscreen

mouse:
  hide_when_typing: true

env:
  TERM: xterm-256color

import:
  - ~/.config/alacritty/themes/themes/$theme " > /home/isvvc/.config/alacritty/alacritty.yml
