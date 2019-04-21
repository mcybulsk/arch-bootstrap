#!/bin/sh

source utils/source-common.sh

echo "Installing xorg"
pacman -S xorg

echo "Installing LightDM"
pacman -S lightdm lightdm-gtk-greeter
systemctl enable lightdm

echo "Installing i3 and other packages"
pacman -S i3-wm i3blocks i3lock i3status \
	rofi \
	libnotify dunst \
	python-pywal feh \
	xautolock \
	xdg-user-dirs
systemctl enable xdg-user-dirs-update

