#!/bin/sh

source utils/source-common.sh

echo "Installing ALSA, PulseAudio and utils"
sudo pacman -S pulseaudio pulseaudio-alsa pulsemixer pasystray pavucontrol

