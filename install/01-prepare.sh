#!/bin/sh

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

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

# Update the system clock
timedatectl set-ntp true

