#!/bin/sh

source utils/source-common.sh

echo "Installing wifi dependencies"
sudo pacman -S networkmanager nm-connection-editor network-manager-applet
sudo systemctl enable NetworkManager
nm-applet &

