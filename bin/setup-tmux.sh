#!/bin/bash

set -e

create-symlink()
{
    FILE=$1
    INSTNAME=$2

    if [ ! -e "$FILE" ]; then
        echo "$FILE does not exist"
        echo "Exiting ..."
        exit
    fi
    
    INSTFILENAME=$(basename "$INSTNAME")
    if [ -e "$INSTNAME" ]; then
        echo "$INSTNAME already exist"
        echo "Do you wish to overwrite $INSTFILENAME? [y/n]"
        read -r yn
        case $yn in
            [Yy]* ) echo "Overwriting $INSTFILENAME";
                rm "$INSTNAME";;
            [Nn]* ) echo "Skipping $INSTFILENAME";
                return 1;;
            * ) echo "Input not understood. Exiting";
                return 1;;
        esac
    fi

    ln -s "$FILE" "$INSTNAME"
}

SCRIPTFULLPATH=$(realpath "$0")
BASEDIR=$(dirname "$SCRIPTFULLPATH")

create-symlink "$BASEDIR/../configs/tmux.conf" ~/.tmux.conf

if [ ! -d ~/.tmux/plugins/tpm ]; then
    mkdir -p "$HOME/.tmux/plugins"

    echo "Installing Tmux Plugin Manager:"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "Installing Tmux plugins:"
~/.tmux/plugins/tpm/bin/install_plugins
