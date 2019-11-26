if-shell '[ -f $HOME/local/bin/tmux ]' " \
    run-shell '$HOME/local/bin/tmux setenv -g TMUX_VERSION $($HOME/local/bin/tmux -V | sed -En 's/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'' " \
    run-shell 'touch Nope' "
