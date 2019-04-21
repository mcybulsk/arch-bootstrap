#!/bin/sh

source utils/source-common.sh

echo "Install yay"
git clone https://aur.archlinux.org/yay.git
pushd yay
makepkg -si
popd

echo "Install a couple of base programs"
sudo pacman -S \
	firefox \
	flameshot \
	keepass \
	ranger python-pillow

echo "Install Dropbox"
gpg --receive-keys FC918B335044912E
yay -S dropbox
rm -rf ~/.dropbox-dist
install -dm0 ~/.dropbox-dist

echo "Install signal and slack"
yay -S signal-desktop-bin slack-desktop

echo "Install i3lock-fancy"
yay -S i3lock-fancy-git

echo "Install Polybar"
yay -S polybar
