#!/bin/bash

sudo pacman -Sy alacritty neovim tmux git openssh firefox curl ripgrep make unzip gcc wget starship;

# jetbrains mono nerd font
mkdir -p ~/.fonts
wget -O ~/.fonts/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
unzip ~/.fonts/JetBrainsMono.zip -d ~/.fonts
fc-cache

# kickstart vim
git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
# add to init.lua
# 'catppuccin/nvim',
# vim.cmd.colorscheme 'catppuccin-mocha'

# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# make bash case insensitive
echo 'set completion-ignore-case On' | sudo tee -a /etc/inputrc
