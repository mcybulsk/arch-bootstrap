#!/bin/sh

source utils/source-common.sh

pacman -Syu \
	git \
	dhcp \
	zsh \
	sudo \
	vim \
	openssh \
	ufw \
	python

# Enable DHCP service
systemctl enable dhcpcd

# Disable SSH password authentication
echo "PasswordAuthentication no" >> /etc/ssh/sshd_config
echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
systemctl enable sshd

# Configure Uncomplicated Firewall
ufw default deny
ufw allow from 192.168.10.0/24
ufw limit SSH
ufw enable

