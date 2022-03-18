#!/bin/bash

sudo apt update
sudo apt install -y software-properties-common

# Add PPAs
sudo add-apt-repository ppa:apandada1/xournalpp-stable
sudo add-apt-repository ppa:longsleep/golang-backports
sudo apt update

sudo apt install -y \
     openssh-server \
     wget \
     curl \
     emacs \
     git \
     golang-go \
     xournalpp \
     python3-cairo-dev \
     libcairo2-dev python3-dev \
     python3-setuptools gettext


sudo apt update

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.nvm/nvm.sh
nvm install 16.14.1

# Enable automatic key mapping
# Copy over the mapping preset(s)
cp -r key-mapper-config ~/.config/key-mapper

#sudo pip3 install --no-binary :all: git+https://github.com/tmclane/key-mapper.git
cd key-mapper
sudo chown -R *
./scripts/build.sh
sudo apt install -y ./dist/key-mapper-1.2.1.deb
sudo sed -i -e "s/USER/$(whoami)/g" /etc/xdg/autostart/key-mapper-autoload.desktop
sudo systemctl enable key-mapper
sudo systemctl restart key-mapper
# Copy script to reapply keymapping every wakeup  | FIXME this doesn't work from deep sleep.
sudo cp 99_jingpad_wakeup /usr/lib/pm-utils/sleep.d

# activate the mapping now so we don't have to wait for a reboot
key-mapper-control --command autoload --config-dir /home/$(whoami)/.config/key-mapper

# Install PPA Packages
# Install Go
# Download PPA Public Key
#sudo apt-key adv --keyserver keyserver.ubuntu.com --receive-keys F6BC817356A3D45E
#echo "deb http://ppa.launchpad.net/longsleep/golang-backports/ubuntu focal main\ndeb-src http://ppa.launchpad.net/longsleep/golang-backports/ubuntu focal main" | sudo tee /etc/apt/sources.list.d/golang.list
#sudo apt update
#sudo apt install -y golang-go

go install golang.org/x/tools/cmd/goimports@latest

# xournal++
#sudo apt install -y xournalpp

# Update scaling of applications
# QT: QT_SCALE_FACTOR=2
# GTK: GDK_DPI_SCALE=2 GDK_SCALE=2
sudo sed --in-place=bak /usr/share/applications/com.github.xournalpp.xournalpp.desktop -e 's/Exec=xournalpp %f/Exec=GDK_DPI_SCALE=2 GDK_SCALE=2 xournalpp %f/g'
