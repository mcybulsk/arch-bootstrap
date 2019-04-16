#!/bin/sh

if ls /sys/firmware/efi/efivars >> /dev/null ; then
        exit 0
fi

exit 1

