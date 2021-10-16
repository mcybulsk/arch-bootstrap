set -e
set -x

# Install base packages
pacstrap /mnt base linux linux-firmware lvm2
genfstab -U /mnt >> /mnt/etc/fstab

echo "Please run command: arch-chroot /mnt"

