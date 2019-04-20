#!/bin/sh

source utils/source-common.sh

pacman -Syu \
	git \
	dhcp \
	zsh \
	sudo \
	vim

# Enable DHCP service
systemctl enable dhcpcd

