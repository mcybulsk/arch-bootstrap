#!/bin/sh

source utils/source-common.sh

echo "Installing grub"
pacman -Syu grub

echo "Which device was used for the Arch installation?"
lsblk
echo -n "Device used for the Arch installation: "
read device
echo -n "Are you sure? Grub will be installed on ${device}. y/n"
read -n1 decision
echo ""

if [ ! ${decision} = "y" ]; then
        echo "Aborting"
        exit 1
fi

echo "Installing grub on ${device}"
grub-install --target=i386-pc #{device}

# FIXME after GRUB installation do https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#Configuring_the_boot_loader_2
root_uuid=lsblk -o NAME,UUID | grep MyVolGroup-root | rev | cut -d' ' -f 1 | rev
echo "Found volume root UUID: ${root_uuid}"
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT=.*/GRUB_CMDLINE_LINUX_DEFAULT="cryptdevice=UUID='${root_uuid}':cryptlvm"'

echo "Generating the main grub configuration file"
grub-mkconfig -o /boot/grub/grub.cfg
echo "All finished! Just please setup the root password."
passwd

echo "All done, please restart: reboot now"

