#!/bin/bash

verify_tmux_version () {
    tmux_version="$($HOME/local/bin/tmux -V | cut -c 6-)"
    echo $tmux_version
    #if [[ $(echo "$tmux_version >= 2.1" | bc) -eq 1  ]] ; then
    #    echo "Version >= 2.1"
    #    exit
    #elif [[ $(echo "$tmux_version >= 1.6" | bc) -eq 1  ]] ; then
    #    echo "Version >= 1.6"
    #    exit
    #else
    #    echo "Version < 1.6"
    #    exit
    #fi
}

verify_tmux_version
