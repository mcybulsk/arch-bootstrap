# arch-bootstrap

First run:
```shell
curl -L https://github.com/mcybulsk/arch-bootstrap/archive/master.tar.gz | tar xvz --
```
or:
```shell
curl -L https://bit.ly/2V85xck | tar xvz --
```
# Dotfiles
```shell
ln -s ${HOME}/arch-bootstrap/dotfiles/home/.* ${HOME}/
pacman -S python
ln -s ${HOME}/arch-bootstrap/dotfiles/config/* ${HOME}/.config/
```


