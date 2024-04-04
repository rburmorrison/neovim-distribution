# Vim/NeoVim Configuration

This is primarily a NeoVim configuration that is compatible with Vim. In order
to use the configuration, add the following to your `~/.vimrc` after installing.

```
source ~/.config/nvim/init.vim
```

The runtime does not need to be modified since all Vim-specific logic is handled
in `init.vim`, including file-specific settings.

**Note:** Last tested with NeoVim v0.10.0-nightly.

## Installing

To install, run the following command (HTTPS):

```
git clone https://github.com/rburmorrison/neovim-distribution.git ~/.config/nvim
```

Or this one (SSH):

```
git clone git@github.com:rburmorrison/neovim-distribution.git ~/.config/nvim
```
