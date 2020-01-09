# .bashrc

# User specific aliases and functions
TERM=xterm-256color
if [ -f ~/.bashrc_aliases ]; then
    . ~/.bashrc_aliases
fi

if [ -f ~/.bashrc_grendel ]; then
   . ~/.bashrc_grendel
fi 

if [ -f ~/.bashrc_mac ]; then
    . ~/.bashrc_mac
fi

if [ -f ~/.bashrc_windows ]; then
    . ~/.bashrc_windows
fi

