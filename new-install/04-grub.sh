set -e
set -x

pacman -S intel-ucode
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ARCH

ENCRYPTED_PARTITION=/dev/nvme1n1p3
ENCRYPTED_PARTITION_UUID=$(blkid | grep "${ENCRYPTED_PARTITION}" | grep -o -E '\sUUID="([a-fA-F0-9-])+"' | cut -d'"' -f2)

sed -i -E 's|GRUB_CMDLINE_LINUX_DEFAULT="(.*)"|GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet cryptdevice=UUID='"${ENCRYPTED_PARTITION_UUID}"':cryptlvm root=/dev/MyVolGroup/root"|' /etc/default/grub

grub-mkconfig -o /boot/grub/grub.cfg

