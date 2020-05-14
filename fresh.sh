#!/bin/bash

# stat - update 
apt update ; apt upgrade -y

apt purge aisleriot gnome-calendar cheese \
gnome-mahjongg gnome-mines gnome-sudoku '^libreoffice-.*' \
remmina rhythmbox totem seahorse shotwell shotwell-common

# remove snap
snap remove snap-store
snap remove gtk-common-themes
snap remove gnome-3-34-1804
snap remove core18

df
echo "What is the core id? Format is /snap/core/xxxx"
read snapCoreId

bash -c "umount /snap/core/$snapCoreId"
apt purge snapd -y

rm -rf /snap
rm -rf /var/snap
rm -rf /var/lib/snapd

# setup
mkdir ~/.icons ~/.themes
apt install -y \
    curl wget git \
    apt-transport-https ca-certificates \    
    gnupg-agent software-properties-common

# oh-my-zsh
apt install zsh -y
chsh -s $(which zsh)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
mkdir -p "$HOME/.zsh"
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh/zsh-syntax-highlighting"
echo "source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
echo "fpath+=$HOME/.zsh/pure" >> ~/.zshrc
echo "autoload -U promptinit; promptinit" >> ~/.zshrc
echo "prompt pure" >> ~/.zshrc

# docker
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
sh -c 'echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable" > /etc/apt/sources.list'
apt update
apt install docker-ce docker-ce-cli containerd.io docker-compose -y

usermod -aG docker $USER

# apps

## chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 
sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'

## vscode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/

## phpstorm
wget https://download-cf.jetbrains.com/webide/PhpStorm-2020.1.tar.gz
tar -xzf PhpStorm-2020.1.tar.gz
sh ./PhpStorm-201.6668.153/bin/PhpStorm.sh 

## flatpak
add-apt-repository ppa:alexlarsson/flatpak

## lutris - gaming
add-apt-repository ppa:lutris-team/lutris

## sublime text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

apt update
apt install -y flatpak gnome-software-plugin-flatpak tmux gnome-tweaks \
    plank htop piper vlc sublime-text slack-desktop code google-chrome-stable \
    lutris mysql-workbench-community steam 

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install flathub com.discordapp.Discord 
flatpak install flathub com.spotify.Client 
flatpak install flathub us.zoom.Zoom 
flatpak install flathub com.calibre_ebook.calibre
 
apt autoremove

echo "Finished. Reboot..."