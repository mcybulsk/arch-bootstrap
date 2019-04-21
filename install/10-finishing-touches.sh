#!/bin/sh

source utils/source-common.sh

echo "Update the system clock"
timedatectl set-ntp true

echo "Set locale to en_US.UTF-8 and keymap to pl"
loadkeys pl
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=pl" > /etc/vconsole.conf

