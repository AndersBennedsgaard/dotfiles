#!/bin/bash

set -e

wait_for_enter() {
    echo
    echo "Press ENTER to continue:"
    read -r -s -n 1 KEY
    if [ "$KEY" == "" ]; then
        return 0
    fi
    return 1
}

cmd () {
    echo "    $1"
    wait_for_enter
}

echo "Install Git. Run:"
cmd "apt update && apt install git"

echo "Create SSH keys. Run:"
cmd "ssh-keygen -t ed25519"

echo "Log into Github.com, and add ~/.ssh/id_ed25519.pub to https://github.com/settings/keys"
wait_for_enter

echo "Clone dotfiles. Run:"
cmd "git clone git@github.com:AndersBennedsgaard/dotfiles.git"

echo "Run:"
cmd "cd dotfiles"

echo "Configure Git. Run:"
cmd "./bin/setup-git.sh"

echo "Install packages. Run:"
cmd "./bin/install-packages.sh"

echo "Set up bash. Run:"
cmd "./bin/setup-bash.sh"

echo "Set up vim. Run:"
cmd "./bin/setup-vim.sh"

echo "Set up tmux. Run:"
cmd "./bin/setup-tmux.sh"

echo "Set up vim/neovim"
wait_for_enter

echo "Done!"
