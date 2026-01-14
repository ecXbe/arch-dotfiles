#!/bin/bash

if [[ ! -f "pkgs.list" ]]; then
    echo -e "Package file not found"
    exit 1
fi
. ./pkgs.list

clear

sudo pacman -Syu

if ! command -v paru &> /dev/null; then
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    cd /tmp/paru
    makepkg -si --noconfirm
    cd ~
    rm -rf /tmp/paru
fi

paru -Syu --needed --removemake --skipreview --norebuild "${required_packages[@]}" "${optional_packages[@]}"
paru -R dolphin

systemctl enable bluetooth

systemctl --user enable pipewire.service
systemctl --user enable pipewire-pulse.service
systemctl --user start pipewire.service
systemctl --user start pipewire-pulse.service
if pacman -Qi power-profiles-daemon &>/dev/null; then
    sudo systemctl enable --now power-profiles-daemon
fi

wal -i ~/arch-dotfiles/wallpapers/pywallpaper.jpg -n

cp -a ~/arch-dotfiles/wallpapers ~/
cp -a ~/arch-dotfiles/.config/* ~/.config/
mkdir -p ~/.themes && cp -a ~/arch-dotfiles/.themes/* ~/.themes/
cp -a ~/arch-dotfiles/.zshrc ~/

if [ "$SHELL" != "/usr/bin/zsh" ]; then
    sudo chsh -s "/usr/bin/zsh" "$USER"
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions
fi

echo
echo "Installation was completed successfully"
