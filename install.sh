#!/bin/bash

# packages
yes | sudo pacman -Sy xdg-desktop-portal-wlr grim slurp wl-clipboard libnotify waybar swayidle kubectx ripgrep-all mpv jq yq tldr nushell argocd helm kubectl man github-cli aws-cli docker mangohud nvidia nvidia-utils lib32-nvidia-utils lazygit fastfetch easyeffects zsh stow wezterm neovim tmux exa openssh firefox curl ripgrep make unzip gcc wget starship libappindicator-gtk3 libdbusmenu-gtk3 libnl jsoncpp libsigc++ fmt chrono-date spdlog libnotify pamixer

# jetbrains mono nerd font
mkdir -p $HOME/.fonts
wget -O $HOME/.fonts/JetBrainsMono.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
unzip $HOME/.fonts/JetBrainsMono.zip -d $HOME/.fonts
fc-cache

# tmux 
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

# oh-my-zsh
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# zsh autosuggestion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# add user to docker group
sudo usermod -aG docker $USER
newgrp docker

# generate xconfig for nvidia driver
sudo nvidia-xconfig
sudo mkinitcpio -P
