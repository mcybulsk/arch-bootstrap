set -e
set -x

# Firewall
sudo ufw enable
sudo ufw default deny
sudo ufw limit ssh

# Yay
git clone https://aur.archlinux.org/yay.git
pushd yay
makepkg -si
popd

# Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# wdisplays
yay -S wdisplays

