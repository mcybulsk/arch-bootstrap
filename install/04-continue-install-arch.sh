#!/bin/sh

source utils/source-common.sh

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

echo "Finished installation. Please install boot loader"
