# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific aliases and functions
TERM=xterm-256color
if [ -f .bashrc_aliases ]; then
    . .bashrc_aliases
fi

if [ -f .bashrc_grendel ]; then
   . .bashrc_grendel
fi 

