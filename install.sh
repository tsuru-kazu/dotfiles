#!/bin/bash

# Neovim
if [ -d ~/.config/nvim ]; then
    echo "Backing up existing nvim config"
    mv ~/.config/nvim ~/.config/nvim.backup
fi
ln -s ~/dotfiles/nvim ~/.config/nvim

# Fish
if [ -d ~/.config/fish ]; then
    echo "Backing up existing fish config"
    mv ~/.config/fish ~/.config/fish.backup
fi
ln -s ~/dotfiles/fish ~/.config/fish

# その他
ln -s ~/dotfiles/.gitconfig ~/.gitconfig
ln -s ~/dotfiles/.tmux.conf ~/.tmux.conf
