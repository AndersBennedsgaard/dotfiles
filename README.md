# Dotfiles

My dotfile configuration.

It is managed with `stow` which creates the necessary symlinks to this directory.

Run `stow <package>` to create a symlink to that package.

For example:

```bash
stow nvim
```

Creates a symlink in `~/.config/nvim/` to `./nvim/dot-config/nvim/`.
