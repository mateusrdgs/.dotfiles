#!/bin/zsh

echo "setting up your MacOS..."

# check if homebrew is installed and install it if not
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# update homebrew
brew update

# install homebrew dependencies
brew tap homebrew/bundle
brew bundle
brew cleanup

# check if oh my zsh folder exists and installs it if not
if [ ! -e ~/.oh-my-zsh ]; then
  /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

echo "finished setup"