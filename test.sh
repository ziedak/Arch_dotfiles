#!/bin/env bash

export DOTFILES_ROOT=$(pwd -P)

source ./utils/link.sh

if [ -d ~/bin ]; then
    backup "$HOME/bin"
fi
    echo "Installing bin scripts..."
    mkdir ~/bin && cp -r ./bin/* ~/bin/;
    
    
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
                echo "export PATH=\$PATH:\$HOME/bin" >> $HOME/Arch_dotfiles/home/zsh/.zshrc
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

    

