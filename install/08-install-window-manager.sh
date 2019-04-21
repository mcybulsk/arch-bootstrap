#!/bin/sh

source utils/source-common.sh

echo "Installing xorg"
pacman -S xorg

echo "Installing LightDM"
pacman -S lightdm
systemctl enable lightdm

echo "Installing i3 and other packages"
pacman -S i3 rofi dunst

