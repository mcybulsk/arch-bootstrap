#!/bin/sh

source utils/source-common.sh

echo "Please choose the device to partition (all data will be lost)"
lsblk
echo -n "Device to be partitioned: "
read device
echo -n "Are you sure? ${device} will be erased. y/n"
read -n1 decision
echo ""

if [ ! ${decision} = "y" ]; then
	echo "Aborting"
	exit 1
fi

echo "Creating a GPT table"
parted -s ${device} mklabel gpt -s 
echo "Creating a boot partition for GPT Grub: ${device}1"
parted -s ${device} mkpart primary ext4 1MiB 3MiB
parted -s ${device} name 1 grub
parted -s ${device} set 1 bios_grub on
echo "Creating a boot partition: ${device}2"
parted -s ${device} mkpart primary ext4 3MiB 1GiB
parted -s ${device} name 2 boot
parted -s ${device} set 2 boot on
# Should probably be 'mkfs.fat -F32 ${device}2' on EFI
mkfs.ext4 ${device}2
echo "Creating an LVM container for LUKS: ${device}3"
parted -s ${device} mkpart extended ext4 1GiB 100%
parted -s ${device} name 3 data
echo "Setting up logical volumes in LUKS container"
cryptsetup luksFormat --type luks2 ${device}3
cryptsetup open ${device}3 cryptlvm
pvcreate /dev/mapper/cryptlvm
vgcreate MyVolGroup /dev/mapper/cryptlvm
lvcreate -L 8G MyVolGroup -n swap
lvcreate -L 32G MyVolGroup -n root
lvcreate -l 100%FREE MyVolGroup -n home
mkfs.ext4 /dev/MyVolGroup/root
mkfs.ext4 /dev/MyVolGroup/home
mkswap /dev/MyVolGroup/swap

echo "Mounting the filesystem on /mnt"
mount /dev/MyVolGroup/root /mnt
mkdir /mnt/home
mount /dev/MyVolGroup/home /mnt/home
swapon /dev/MyVolGroup/swap
mkdir /mnt/boot
mount ${device}2 /mnt/boot
echo "Filesystem mounted"
find /mnt


