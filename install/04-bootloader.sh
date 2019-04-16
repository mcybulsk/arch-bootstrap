#!/bin/sh

source utils/source-common.sh

# FIXME after GRUB installation do https://wiki.archlinux.org/index.php/Dm-crypt/Encrypting_an_entire_system#Configuring_the_boot_loader_2
root_uuid=lsblk -o NAME,UUID | grep MyVolGroup-root | rev | cut -d' ' -f 1 | rev

