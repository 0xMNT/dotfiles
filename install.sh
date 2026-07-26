#!/usr/bin/env bash
#
# Bootstraps a fresh Arch install to match this dotfiles repo.
# Safe to re-run: every step checks whether it already applied.
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

log() { printf '\n\033[1;34m==>\033[0m %s\n' "$1"; }

if [[ ! -f /etc/arch-release ]]; then
    echo "This script targets Arch Linux. Aborting." >&2
    exit 1
fi

if [[ $EUID -eq 0 ]]; then
    echo "Don't run this as root, it sudo's when it needs to." >&2
    exit 1
fi

HOST_NAME="$(cat /etc/hostname)"

# --- base tooling ---------------------------------------------------------
log "Installing base tooling (git, base-devel, stow)"
sudo pacman -S --needed --noconfirm git base-devel stow

# --- AUR helper -------------------------------------------------------------
if ! command -v yay >/dev/null 2>&1; then
    log "Installing yay (AUR helper)"
    tmpdir="$(mktemp -d)"
    git clone --depth 1 https://aur.archlinux.org/yay-bin.git "$tmpdir/yay-bin"
    (cd "$tmpdir/yay-bin" && makepkg -si --noconfirm)
    rm -rf "$tmpdir"
else
    log "yay already installed, skipping"
fi

# --- packages ---------------------------------------------------------------
log "Installing official packages (packages/pkglist.txt)"
sudo pacman -Syu --needed --noconfirm - < packages/pkglist.txt

log "Installing AUR packages (packages/pkglist-aur.txt)"
yay -S --needed --noconfirm - < packages/pkglist-aur.txt

# --- dotfiles symlinks -------------------------------------------------------
# sddm's files live under etc/ and get copied (not symlinked) further down;
# packages/ is just the package lists above, not something to link into $HOME.
STOW_SKIP=(sddm packages)

# Fresh Arch installs ship default .bashrc/.bash_profile/.bash_logout from
# /etc/skel; stow refuses to overwrite real files, so move them aside first.
for f in .bash_logout .bash_profile .bashrc; do
    if [[ -e "$HOME/$f" && ! -L "$HOME/$f" ]]; then
        mv "$HOME/$f" "$HOME/$f.orig"
    fi
done

log "Stowing dotfiles into \$HOME"
stow_targets=()
for dir in */; do
    dir="${dir%/}"
    skip=false
    for ignore in "${STOW_SKIP[@]}"; do
        [[ "$dir" == "$ignore" ]] && skip=true && break
    done
    $skip || stow_targets+=("$dir")
done
stow -v -R -t "$HOME" "${stow_targets[@]}"

# --- host-specific configs ---------------------------------------------------
log "Linking Hyprland config for host: $HOST_NAME"
if [[ -f "$HOME/.config/hypr/hosts/${HOST_NAME}.conf" ]]; then
    ln -sf "$HOME/.config/hypr/hosts/${HOST_NAME}.conf" "$HOME/.config/hypr/host.conf"
else
    echo "  No hosts/${HOST_NAME}.conf, falling back to common.conf" >&2
    ln -sf "$HOME/.config/hypr/hosts/common.conf" "$HOME/.config/hypr/host.conf"
fi

log "Merging waybar config for host: $HOST_NAME"
"$HOME/.config/waybar/merge-config.sh"

# --- fonts --------------------------------------------------------------------
if ! fc-list | grep -qi "JetBrainsMono Nerd Font"; then
    log "Installing JetBrains Mono Nerd Font"
    mkdir -p "$HOME/.fonts"
    curl -fLo "$HOME/.fonts/JetBrainsMono.zip" \
        https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/JetBrainsMono.zip
    unzip -o "$HOME/.fonts/JetBrainsMono.zip" -d "$HOME/.fonts/JetBrainsMono"
    rm "$HOME/.fonts/JetBrainsMono.zip"
    fc-cache -f
else
    log "JetBrains Mono Nerd Font already installed, skipping"
fi

# --- tmux plugin manager --------------------------------------------------------
if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
    log "Installing tmux plugin manager (tpm)"
    git clone --depth 1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
else
    log "tpm already installed, skipping"
fi

# --- oh-my-zsh ------------------------------------------------------------------
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    log "Installing oh-my-zsh"
    # KEEP_ZSHRC: don't clobber the .zshrc that stow just symlinked in above.
    # RUNZSH=no: don't drop into a new zsh mid-script.
    RUNZSH=no CHSH=yes KEEP_ZSHRC=yes sh -c \
        "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    log "oh-my-zsh already installed, skipping"
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
    log "Installing zsh-autosuggestions"
    git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
    log "zsh-autosuggestions already installed, skipping"
fi

# --- sddm autologin -----------------------------------------------------------------
log "Configuring SDDM autologin"
sudo mkdir -p /etc/sddm.conf.d
sudo cp sddm/etc/sddm.conf.d/autologin.conf /etc/sddm.conf.d/autologin.conf
sudo systemctl enable sddm

# --- nvidia ----------------------------------------------------------------------------
if lspci | grep -qi nvidia; then
    log "NVIDIA GPU detected: generating xorg config and rebuilding initramfs"
    sudo nvidia-xconfig
    sudo mkinitcpio -P
else
    log "No NVIDIA GPU detected, skipping nvidia-xconfig"
fi

log "Done. Log out and back in (or reboot) for group membership and shell changes to apply."
