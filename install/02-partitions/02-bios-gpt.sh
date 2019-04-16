#!/bin/sh

echo "Please choose the device to partition (all data will be lost)"
lsblk
echo -n "Device to be partitioned: "
read device
echo -n "Are you sure? ${device} will be erased. y/n"
read -q

if [ $? -ne 0 ]; then
	echo "Aborting"
	exit 1
fi

echo "Creating a GPT table"
parted -s ${device} mklabel gpt -s 
echo "Creating a boot partition for GPT Grub: ${device}1"
parted -s ${device} mkpart primary ext4 1MiB 3MiB
parted -s ${device} name 1 grub
parted -s ${device} set 1 bios_grub on
echo "Creating a boot partition"
parted -s ${device} mkpart primary ext4 3MiB 1GiB
parted -s ${device} name 2 boot
echo "Creating an LVM container for LUKS"
parted -s ${device} mkpart extended ext4 1GiB 100%
parted -s ${device} name 3 data
