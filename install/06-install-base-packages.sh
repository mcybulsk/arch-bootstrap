#!/bin/sh

source utils/source-common.sh

pacman -Syu \
	git \
	dhcp \
	zsh \
	sudo

# Enable DHCP service
systemctl enable dhcpcd

