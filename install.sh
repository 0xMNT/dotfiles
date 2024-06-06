#!/bin/bash

# packages
yes | sudo pacman -Sy docker mangohud nvidia nvidia-utils lib32-nvidia-utils lazygit fastfetch easyeffects zsh stow wezterm neovim tmux exa openssh firefox curl ripgrep make unzip gcc wget starship

# jetbrains mono nerd font
mkdir -p ~/.fonts
wget -O ~/.fonts/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip
unzip ~/.fonts/JetBrainsMono.zip -d ~/.fonts
fc-cache

# tmux 
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# oh-my-zsh
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# zsh autosuggestion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# add user to docker group
sudo usermod -aG docker $USER
newgrp docker

# generate xconfig for nvidia driver
sudo nvidia-xconfig
sudo mkinitcpio -P
