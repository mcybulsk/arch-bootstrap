#!/bin/sh

source utils/source-common.sh

NEW_USER_NAME=${NEW_USER_NAME:-michal}

echo "Adding user: ${NEW_USER_NAME}"
useradd -m -s /bin/zsh ${NEW_USER_NAME}

echo "Adding to sudoers"
echo "${NEW_USER_NAME}"' ALL=(ALL:ALL) ALL' | EDITOR='tee -a' visudo
pushd /home/${NEW_USER_NAME}
sudo -u ${NEW_USER_NAME} mkdir -p .config
sudo -u ${NEW_USER_NAME} git clone https://github.com/mcybulsk/arch-bootstrap.git
sudo -u ${NEW_USER_NAME} ln -s /home/${NEW_USER_NAME}/arch-bootstrap/dotfiles/config/* .config/

sudo -u ${NEW_USER_NAME} ln -s /home/${NEW_USER_NAME}/arch-bootstrap/dotfiles/config/* .config/
sudo -u ${NEW_USER_NAME} ln -s /home/${NEW_USER_NAME}/arch-bootstrap/dotfiles/home .

popd

