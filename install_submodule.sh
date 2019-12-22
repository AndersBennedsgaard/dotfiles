#!/bin/bash

# Vim or Tmux
SSH_LINK=$1
INSTALL_DIR=$2

git submodule add $SSH_LINK $INSTALL_DIR
