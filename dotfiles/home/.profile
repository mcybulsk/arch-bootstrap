export PATH="${HOME}/env/bin:${PATH}"

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [ ! "$SSH_AUTH_SOCK" ]; then
    eval "$(<~/.ssh-agent-thing)"
fi

export XKB_DEFAULT_LAYOUT=pl
export XDG_CONFIG_HOME="${HOME}/.config"

# For compability with XWayland (running soft in Wayland mode when X is also available). Source: https://wiki.archlinux.org/title/Wayland#GUI_libraries
export GDK_BACKEND=wayland
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt5ct
export CLUTTER_BACKEND=wayland
export SDL_VIDEODRIVER=wayland

# Fix for Intellij Idea
# export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on'
export _JAVA_AWT_WM_NONREPARENTING=1

# Dart & Flutter
export ANDROID_SDK_ROOT="${HOME}/env/android/cmdline-tools/latest"
export ANDROID_SDK_HOME="${ANDROID_SDK_ROOT}"
export PATH="${HOME}/env/flutter/bin:${ANDROID_SDK_ROOT}/bin:${PATH}"

# flyctl
export FLYCTL_INSTALL="/home/michal/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

export CHROME_EXECUTABLE=google-chrome-stable

# Set keyboard backlight to white
asusctl led-mode static -c ffffff
