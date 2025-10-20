#!/bin/bash

set -e

if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git /tmp/yay
    cd /tmp/yay
    makepkg -si --noconfirm
    cd ~
    rm -rf /tmp/yay
fi

yay -S python-pywal16 swww waybar swaync starship myfetch neovim python-pywalfox hypridle hyprpicker hyprshot hyprlock pacman-contrib pyprland wlogout fd cava brightnessctl clock-rs-git nerd-fonts noto-fonts-emoji ttf-jetbrains-mono nwg-look bibata-cursor-theme thunar gvfs tumbler eza htop libreoffice-fresh libreoffice-fresh-ru blueman bluez pipewire pipewire-pulse pipewire-alsa pipewire-jack pavucontrol gnome-network-displays gst-plugins-bad

systemctl enable bluetooth

systemctl --user enable pipewire.service
systemctl --user enable pipewire-pulse.service
systemctl --user start pipewire.service
systemctl --user start pipewire-pulse.service

hyprpm add https://github.com/virtcode/hypr-dynamic-cursors
hyprpm enable dynamic-cursors

selected_wallpaper="$HOME/arch-dotfiles/wallpapers/walls/MistyTrees.jpg"

swww img "$selected_wallpaper" --transition-type any --transition-fps 60 --transition-duration .5
wal -i "$selected_wallpaper" -n --cols16
swaync-client --reload-css
cat ~/.cache/wal/colors-kitty.conf > ~/.config/kitty/current-theme.conf
pywalfox update
color1=$(awk 'match($0, /color2=\47(.*)\47/,a) { print a[1] }' ~/.cache/wal/colors.sh)
color2=$(awk 'match($0, /color3=\47(.*)\47/,a) { print a[1] }' ~/.cache/wal/colors.sh)
cava_config="$HOME/.config/cava/config"
sed -i "s/^gradient_color_1 = .*/gradient_color_1 = '$color1'/" $cava_config
sed -i "s/^gradient_color_2 = .*/gradient_color_2 = '$color2'/" $cava_config
pkill -USR2 cava 2>/dev/null
source ~/.cache/wal/colors.sh && cp -r "$selected_wallpaper" ~/wallpapers/pywallpaper.jpg

sudo cp -a ~/arch-dotfiles/wallpapers ~/
sudo cp -a ~/arch-dotfiles/.config/* ~/.config/
sudo cp -a ~/arch-dotfiles/.themes/* ~/.themes/
sudo cp -a ~/arch-dotfiles/.bashrc ~/

clear

echo ".___ _______    _________________________  .____    .____       ________________.___________    _______   "
echo "|   |\\      \\  /   _____/\\__    ___/  _  \\ |    |   |    |     /  _  \\__    ___/|   \\_____  \\   \\      \\  "
echo "|   |/   |   \\ \\_____  \\   |    | /  /_\\  \\|    |   |    |    /  /_\\  \\|    |   |   |/   |   \\  /   |   \\ "
echo "|   /    |    \\/        \\  |    |/    |    \\    |___|    |___/    |    \\    |   |   /    |    \\/    |    \\"
echo "|___\\____|__  /_______  /  |____|\\____|__  /_______ \\_______ \\____|__  /____|   |___\\_______  /\\____|__  /"
echo "            \\/        \\/                 \\/        \\/       \\/       \\/                     \\/         \\/ "
echo "                                  __      __  _____    _________                                          "
echo "                                 /  \\    /  \\/  _  \\  /   _____/                                          "
echo "                                 \\   \\/\\/   /  /_\\  \\ \\_____  \\                                           "
echo "                                  \\        /    |    \\/        \\                                          "
echo "                                   \\__/\\  /\\____|__  /_______  /                                          "
echo "                                        \\/         \\/        \\/                                           "
echo "  _____________ ____________ _________ ___________ _________ ________________________ ___.____            "
echo " /   _____/    |   \\_   ___ \\\\_   ___ \\\\_   _____//   _____//   _____/\\_   _____/    |   \\    |           "
echo " \\_____  \\|    |   /    \\  \\//    \\  \\/ |    __)_ \\_____  \\ \\_____  \\  |    __) |    |   /    |           "
echo " /        \\    |  /\\     \\___\\     \\____|        \\/        \\/        \\ |     \\  |    |  /|    |___        "
echo "/_______  /______/  \\______  /\\______  /_______  /_______  /_______  / \\___  /  |______/ |_______ \\       "
echo "        \\/                 \\/        \\/        \\/        \\/        \\/      \\/                    \\/       "
