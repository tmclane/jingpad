#!/bin/bash

sudo apt update
sudo apt install openssh-server wget curl git emacs \
     cairo-dev python3-cairo-dev \
     libcairo2-dev python3-dev \
     python3-key-mapper python-pip3 \
     python3-setuptools gettext

# Enable automatic key mapping
# Copy over the mapping preset(s)
cp -r key-mapper-config ~/.config/key-mapper

#sudo pip3 install --no-binary :all: git+https://github.com/tmclane/key-mapper.git
cd key-mapper
./scripts/build.sh
sudo apt install ./dist/key-mapper-1.2.1.deb
sudo sed -i -e "s/USER/$(whoami)/g" /etc/xdg/autostart/key-mapper-autoload.desktop
sudo systemctl enable key-mapper
sudo systemctl restart key-mapper

# activate the mapping now so we don't have to wait for a reboot
key-mapper-control --command autoload --config-dir /home/$(whoami)/.config/key-mapper
