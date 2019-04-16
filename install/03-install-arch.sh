#!/bin/sh

source utils/source-common.sh

echo "Installing missing dependency"
pacman -Sy pacman-contrib
echo "Setting up the /etc/pacman.d/mirrorlist file"
curl -s "https://www.archlinux.org/mirrorlist/?country=PL&country=DE&protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 - > /etc/pacman.d/mirrorlist
echo "Installing base system packages"
pacstrap /mnt base base-devel
echo "Finished installing base system packages!"

echo "Generating the /etc/fstab"
genfstab -U /mnt >> /mnt/etc/fstab

echo "Changing chroot to the new system"
arch-chroot /mnt

echo "Setting up the time"
ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
hwclock --systohc

echo "Setting up the locale"
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=pl" > /etc/vconsole.conf

echo "Setting up the hostname"
echo -n "What is the hostname?: "
read new_hostname
echo "${new_hostname}" > /etc/hostname
rm /etc/hosts
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1 localhost" >> /etc/hosts

echo "Recreating initramfs image"
mkinitcpio -p linux

cp -r ../ /mnt/tmp/arch-bootstrap-master
echo "Finished installation. Please continue installation after invoking these commands:"
echo "---"
echo "arch-chroot /mnt"
echo "cd /tmp/arch-bootstrap-master/install"
echo "---"

