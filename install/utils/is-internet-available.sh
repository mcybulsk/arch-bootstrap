#!/bin/sh

if curl -s google.com >> /dev/null ; then
        echo "Internet connection available!"
	exit 0
fi

exit 1

