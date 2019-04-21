#!/bin/sh

source utils/source-common.sh

echo "Installing needed packages"
pacman -S bumblebee mesa nvidia-390xx nvidia-390xx-utils nvidia-390xx-settings xf86-video-intel
systemctl enable bumblebeed

echo "Done, remember to run 'sudo gpasswd -a $USER bumblebee' later"

