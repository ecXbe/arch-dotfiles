#!/bin/bash

if [[ ! -f "pkgs.list" ]]; then
    echo -e "Package file not found"
    exit 1
fi
. ./pkgs.list

clear

sudo pacman -Syu

if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd ~
    rm -rf /tmp/yay
fi

yay -S --needed --noconfirm --removemake "${required_packages[@]}" "${optional_packages[@]}"

systemctl enable bluetooth

systemctl --user enable pipewire.service
systemctl --user enable pipewire-pulse.service
systemctl --user start pipewire.service
systemctl --user start pipewire-pulse.service

wal -i ~/arch-dotfiles/wallpapers/pywallpaper.jpg -n

cp -a ~/arch-dotfiles/wallpapers ~/
cp -a ~/arch-dotfiles/.config/* ~/.config/
cp -a ~/arch-dotfiles/.themes/* ~/.themes/
cp -a ~/arch-dotfiles/.bashrc ~/

echo
echo "Installation was completed successfully"
