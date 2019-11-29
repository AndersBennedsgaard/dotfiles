#!/bin/bash

# Script for installing tmux on systems where you don't have root access.
# tmux will be installed in $HOME/local/bin.
# It's assumed that wget and a C/C++ compiler are installed.

# From 
#  https://gist.github.com/ryin/3106801
#  https://superuser.com/questions/1259140/how-to-install-tmux-locally-without-root-access

# exit on error
set -e

TMUX_VERSION=2.6

TMUX=tmux-${TMUX_VERSION}
LIBEVENT=libevent-2.1.11-stable
NCURSES=ncurses-5.9

# create our directories
mkdir -p $HOME/local $HOME/tmux_tmp
cd $HOME/tmux_tmp

# download source files for tmux, libevent, and ncurses
wget -O ${TMUX}.tar.gz https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/${TMUX}.tar.gz
wget https://github.com/libevent/libevent/releases/download/release-2.1.11-stable/${LIBEVENT}.tar.gz
wget ftp://ftp.gnu.org/gnu/ncurses/${NCURSES}.tar.gz

# extract files, configure, and compile

############
# libevent #
############
tar xvzf ${LIBEVENT}.tar.gz
cd ${LIBEVENT}
./configure --prefix=$HOME/local --disable-shared
make
make install
cd ..

############
# ncurses  #
############
tar xvzf ${NCURSES}.tar.gz
cd ${NCURSES}
./configure --prefix=$HOME/local CPPFLAGS="-P"
make
make install
cd ..

############
# tmux     #
############
tar xvzf ${TMUX}.tar.gz
cd ${TMUX}
./configure CFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-L$HOME/local/lib -L$HOME/local/include/ncurses -L$HOME/local/include"
CPPFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" LDFLAGS="-static -L$HOME/local/include -L$HOME/local/include/ncurses -L$HOME/local/lib" make
cp tmux $HOME/local/bin
cd ..

# cleanup
rm -rf $HOME/tmux_tmp

echo "$HOME/local/bin/tmux is now available. You can optionally add $HOME/local/bin to your PATH."
