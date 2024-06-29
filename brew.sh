#!/bin/bash
# Install Homebrew if it's not already installed
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install packages from Brewfile
brew bundle --file=~/dotfiles/Brewfile