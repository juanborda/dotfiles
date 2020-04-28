#!/bin/bash

# stat - update 
sudo apt update ; sudo apt upgrade -y

sudo apt purge aisleriot gnome-mahjongg gnome-mines gnome-software-plugin-snap remmina remmina-plugind-rdp remmina-plugin-secret remmina-plugin-vnc rhythmbox rhythmbox-plugin-alternative-toolbar rhythmbox-plugins snapd thunderbird thunderbird-gnome-support thunderbird-locale-en thunderbird-locale-en-gb thunderbird-locale-en-us
gnome-sudoku gnome-games-common gbrainy brltty duplicity empathy empathy-common example-content gnome-accessibility-themes gnome-contacts gnome-mahjongg gnome-mines gnome-orca gnome-screensaver gnome-sudoku gnome-video-effects gnomine landscape-common libreoffice-avmedia-backend-gstreamer libreoffice-base-core libreoffice-calc libreoffice-common libreoffice-core libreoffice-draw libreoffice-gnome libreoffice-gtk libreoffice-impress libreoffice-math libreoffice-ogltrans libreoffice-pdfimport libreoffice-style-galaxy libreoffice-style-human libreoffice-writer totem totem-common totem-plugins gnome-todo -y

# remove snap
sudo snap remove snap-store
sudo snap remove gtk-common-themes
sudo snap remove gnome-3-34-1804
sudo snap remove core18

df
echo "What is the core id?"
read snapCoreId

echo "Value entered was: " $snapCoreId

sudo umount /snap/core/$snapCoreId
sudo apt purge snapd -y

sudo rm -rf /snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd

sudo apt autoremove

# setup
mkdir ~/.icons ~/.themes
sudo apt install wget curl git -y

# oh-my-zsh
sudo apt install zsh -y
sudo chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
"source /home/juanb/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
"fpath+=$HOME/.zsh/pure" >> ~/.zshrc
"autoload -U promptinit; promptinit" >> ~/.zshrc
"prompt pure" >> ~/.zshrc

# docker

sudo apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io -y
sudo usermod -aG docker juanb

# apps
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
rm ./google-chrome-stable_current_amd64.deb

wget https://download-cf.jetbrains.com/webide/PhpStorm-2020.1.tar.gz
tar -xzf PhpStorm-2020.1.tar.gz
sh ./PhpStorm-2020.1/bin/PhpStorm.sh 
sudo rm -rf ./PhpStorm-2020.1

sudo sh -c \
	'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install code -y


sudo apt install tmux tweaks plank htop -y

# TWEAKS - dash to dock - better osd - freon - remove dropdown arrow - user themes

flatpak install com.discordapp.Discord com.sublimetext.three \
 com.spotify.Client com.valvesoftware.Steam com.github.alecaddd.sequeler com.slack.Slack \
 us.zoom.Zoom org.videolan.VLC com.calibre_ebook.calibre
