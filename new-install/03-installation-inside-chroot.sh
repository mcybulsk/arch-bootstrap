set -e
set -x

HOSTNAME=mercury

ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
timedatectl set-ntp true
hwclock --systohc
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
echo 'KEYMAP=pl' > /etc/vconsole.conf

echo "${HOSTNAME}" > /etc/hostname

tee /etc/hosts << EOF
127.0.0.1 localhost
::1 localhost
EOF

sed -i -E 's/^MODULES=(.*)/MODULES=(vmd)/' /etc/mkinitcpio.conf
sed -i -E 's/^HOOKS=(.*)/HOOKS=(base udev autodetect keyboard keymap consolefont modconf block encrypt lvm2 filesystems fsck)/' /etc/mkinitcpio.conf
mkinitcpio -P

echo "Please provide new root password"
passwd
