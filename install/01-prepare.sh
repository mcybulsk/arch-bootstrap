#!/bin/sh

source utils/source-common.sh

# Verify internet connection
if ! utils/is-internet-available.sh ; then
	echo "Internet is not available!"
	exit 1
fi

# Verify boot mode
if utils/is-efi.sh ; then
	echo "System has EFI"
else
	echo "System does not have EFI"
fi

echo "Update the system clock"
timedatectl set-ntp true

echo "Set locale to en_US.UTF-8 and keymap to pl"
loadkeys pl
sed -i 's/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=pl" > /etc/vconsole.conf

