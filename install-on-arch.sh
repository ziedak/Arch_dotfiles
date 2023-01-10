#!/bin/env bash

source ./utils/colors.sh
source ./utils/link.sh

#Default vars
DOTFILES_ROOT=$(pwd -P)
HELPER="paru"
IS_VM=false

set -e
echo "Welcome!" && sleep 2


# Install Fonts
install_fonts() {
    echo -e "\n[*] Installing fonts..."
    FDIR="~/.local/share/fonts"
    [[ ! -d "$FDIR" ]] && mkdir -p "$FDIR"
    cp -rf ./fonts/* "$FDIR"
    fc-cache -f
}


# does full system update
echo "Doing a system update, cause stuff may break if it's not the latest version..."
#sudo pacman --noconfirm -Syu

echo "###########################################################################"
echo "Will do stuff, get ready"
echo "###########################################################################"

# install base-devel if not installed
#sudo pacman -S --noconfirm --needed base-devel wget git

# choose video driver
echo "1) xf86-video-intel 	2) xf86-video-amdgpu 3) nvidia 4) vmware 5) Skip"
read -r -p "Choose you video card driver(default 1)(will not re-install): " vid

case $vid in 
    [1])
        DRI='xf86-video-intel'
        ;;

    [2])
        DRI='xf86-video-amdgpu'
        ;;

    [3])
        DRI='nvidia nvidia-settings nvidia-utils'
        ;;

    [4])
    #Enable vmware-vmblock-fuse.service and vmtoolsd.service.
    #Add vmware-user to Xinitrc.
        DRI="gtkmm3  mesa open-vm-tools xf86-input-vmmouse xf86-video-vmware"
        ;;
    [5])
        DRI=""
        ;;
    [*])
        DRI=""
        ;;
esac

# install xorg if not installed
sudo pacman -S --noconfirm --needed rofi feh xorg xorg-xinit xorg-xinput $DRI awesome neovim

# install fonts


echo "We need an AUR helper. It is essential. 1) paru       2) yay"
read -r -p "What is the AUR helper of your choice? (Default is paru): " num

if [ $num -eq 2 ]
then
    HELPER="yay"
fi

if ! command -v $HELPER &> /dev/null
then
    echo "It seems that you don't have $HELPER installed, I'll install that for you before continuing."
    mkdir -p ~/.srcs
	git clone https://aur.archlinux.org/$HELPER.git ~/.srcs/$HELPER
	(cd ~/.srcs/$HELPER/ && makepkg -si )
fi

$HELPER -S picom-jonaburg-git\
	   acpi              \
	   alacritty         \
       direnv           \
	   xautolock         \
	   betterlockscreen


# wallpaper
if [ -d ~/wallpapers ]; then
    echo "Adding wallpaper to ~/wallpapers..."
    cp ./wallpapers/yosemite-lowpoly.jpg ~/wallpapers/;
else
    echo "Installing wallpaper..."
    mkdir ~/wallpapers && cp -r ./wallpapers/* ~/wallpapers/;
fi

# config
install_configs

bin dir
if [ -d ~/bin ]; then
    backup "~/bin"
else
    echo "Installing bin scripts..."
    mkdir ~/bin && cp -r ./bin/* ~/bin/;
    clear
    
    # auto run
    SHELLNAME=$(echo $SHELL | grep -o '[^/]*$')
    case $SHELLNAME in
        bash)
            if [[ ":$PATH:" == *":$HOME/bin:"* ]]; then
                echo "Looks like $HOME/bin is not on your PATH, adding it now."
                echo "export PATH=\$PATH:\$HOME/bin" >> $HOME/.bashrc
            else
                echo "$HOME/bin is already in your PATH. Proceeding."
            fi
            ;;

        zsh)
            if [[ ":$PATH:" == *":$HOME/bin:"* ]]; then
                echo "Looks like $HOME/bin is not on your PATH, adding it now."
                echo "export PATH=\$PATH:\$HOME/bin" >> $HOME/.zshrc
            else
                echo "$HOME/bin is already in your PATH. Proceeding."
            fi
            ;;

        fish)
            echo "I see you use fish. shahab96 likes your choice."
            fish -c fish_add_path -P $HOME/bin
            ;;

        *)
            echo "Please add: export PATH='\$PATH:$HOME/bin' to your .bashrc or whatever shell you use."
            echo "If you know how to add stuff to shells other than bash, zsh and fish please help out here!"
    esac
fi
    


# done 
sleep 5
