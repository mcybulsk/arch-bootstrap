export PATH="${HOME}/env/bin:${PATH}"

if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [ ! "$SSH_AUTH_SOCK" ]; then
    eval "$(<~/.ssh-agent-thing)"
fi

export XKB_DEFAULT_LAYOUT=pl

