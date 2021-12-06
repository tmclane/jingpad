#!/bin/bash


sudo apt update
sudo apt install -y openssh-server wget curl emacs \
     cairo-dev python3-cairo-dev \
     libcairo2-dev python3-dev \
     python3-key-mapper python-pip3 \
     python3-setuptools gettext gunzip

# Enable automatic key mapping
# Copy over the mapping preset(s)
cp -r key-mapper-config ~/.config/key-mapper

#sudo pip3 install --no-binary :all: git+https://github.com/tmclane/key-mapper.git
cd key-mapper
./scripts/build.sh
sudo apt install -y ./dist/key-mapper-1.2.1.deb
sudo sed -i -e "s/USER/$(whoami)/g" /etc/xdg/autostart/key-mapper-autoload.desktop
sudo systemctl enable key-mapper
sudo systemctl restart key-mapper
# Copy script to reapply keymapping every wakeup
sudo cp 99_jingpad_wakeup /usr/lib/pm-utils/sleep.d

# activate the mapping now so we don't have to wait for a reboot
key-mapper-control --command autoload --config-dir /home/$(whoami)/.config/key-mapper

# Install PPA Packages
# Install Go
# Download PPA Public Key
sudo apt-key adv --keyserver keyserver.ubuntu.com --receive-keys F6BC817356A3D45E
echo "deb http://ppa.launchpad.net/longsleep/golang-backports/ubuntu focal main\ndeb-src http://ppa.launchpad.net/longsleep/golang-backports/ubuntu focal main" | sudo tee /etc/apt/sources.list.d/golang.list
sudo apt update
sudo apt install -y golang-go

