#!/bin/bash

# stat - update 
sudo apt update ; sudo apt upgrade -y

sudo apt purge aisleriot gnome-calendar cheese \
gnome-mahjongg gnome-mines gnome-sudoku '^libreoffice-.*' remmina rhythmbox totem

# remove snap
sudo snap remove snap-store
sudo snap remove gtk-common-themes
sudo snap remove gnome-3-34-1804
sudo snap remove core18

df
echo "What is the core id?"
read snapCoreId

echo "Value entered was: " $snapCoreId

sudo umount "/snap/core/$snapCoreId"
sudo apt purge snapd -y

sudo rm -rf /snap
sudo rm -rf /var/snap
sudo rm -rf /var/lib/snapd

# setup
mkdir ~/.icons ~/.themes
sudo apt install wget curl git -y

# oh-my-zsh
sudo apt install zsh -y
sudo chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh/zsh-syntax-highlighting"
echo "source /home/juanb/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
echo "fpath+=$HOME/.zsh/pure" >> ~/.zshrc
echo "autoload -U promptinit; promptinit" >> ~/.zshrc
echo "prompt pure" >> ~/.zshrc

# docker

sudo apt install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common -y

curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" > /etc/apt/sources.list'
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io -y
sudo apt install docker-compose -y

sudo usermod -aG docker juanb

# apps
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/

sudo apt update
sudo apt install code -y
sudo apt install google-chrome-stable -y

wget https://download-cf.jetbrains.com/webide/PhpStorm-2020.1.tar.gz
tar -xzf PhpStorm-2020.1.tar.gz
sh ./PhpStorm-201.6668.153/bin/PhpStorm.sh 

sudo add-apt-repository ppa:alexlarsson/flatpak
sudo apt update
sudo apt install tmux gnome-tweaks plank htop -y

# TWEAKS - dash to dock - better osd - freon - remove dropdown arrow - user themes
sudo apt install flatpak gnome-software-plugin-flatpak -y
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.discordapp.Discord 
flatpak install flathub com.sublimetext.three 
flatpak install flathub com.spotify.Client 
flatpak install flathub com.valvesoftware.Steam 
flatpak install flathub com.github.alecaddd.sequeler 
flatpak install flathub com.slack.Slack 
flatpak install flathub us.zoom.Zoom 
flatpak install flathub org.videolan.VLC 
flatpak install flathub com.calibre_ebook.calibre
 
sudo apt autoremove

echo "Finished. Reboot..."
 
