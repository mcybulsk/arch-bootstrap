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

mkdir -p /mnt/tmp/arch-bootstrap-master
cp -r ../ /mnt/tmp/arch-bootstrap-master
chmod -R 777 /mnt/tmp/arch-bootstrap-master
echo "Finished installation. Please continue installation after invoking these commands:"
echo "---"
echo "arch-chroot /mnt"
echo "cd /tmp/arch-bootstrap-master/install"
echo "---"

