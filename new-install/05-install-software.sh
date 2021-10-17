set -e
set -x

# System core
pacman -S \
	git \
	base-devel \
	zsh \
	sudo \
	vim \
	reflector \
	openssh \
	screen \
	zip \
	unzip \
	htop \
	brightnessctl

# Power management
pacman -S tlp
systemctl enable tlp.service

# Audio
pacman -S alsa \
	alsa-utils \
	pulseaudio \
	pulseaudio-alsa \
	pamixer \
	pavucontrol

# Configure mirrors
reflector > /etc/pacman.d/mirrorlist 

# Firewall
pacman -S iptables ufw
systemctl enable iptables.service
systemctl enable ufw.service

# Networking
pacman -S networkmanager # network-manager-applet nm-connection-editor
systemctl enable NetworkManager.service

# Graphical interface
pacman -S \
	xf86-video-intel \
	xf86-video-nouveau \
	xf86-input-libinput \
        mesa \
	sway \
	swayidle \
	swaylock \
	swaybg \
	waybar \
	bemenu \
	qt5-wayland \
	qt6-wayland \
	qt5ct \
	xorg-xwayland \
	kanshi

# Utilities
pacman -S kitty \
	firefox
