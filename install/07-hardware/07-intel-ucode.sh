#!/bin/sh

source utils/source-common.sh

echo "Installing intel microcode package"
pacman -S intel-ucode
echo "Regenerating the GRUB configuration"
grub-mkconfig -o /boot/grub/grub.cfg

