set -e
set -x

USER_NAME=michal

useradd -m -s /bin/zsh "${USER_NAME}"

echo "${USER_NAME} ALL=(ALL) ALL" > "/etc/sudoers.d/10-${USER_NAME}"


# FIXME printer, better sound, i3 config

