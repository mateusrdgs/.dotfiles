#!/bin/bash

echo "setting up your MacOS..."

echo "symlinking dotfiles..."

dotfiles='.gitconfig .zshrc'

for df in $dotfiles; do
  if [ -e ~/$df ] || [ -L ~/$df ]; then # file exists or if exists and is a symlink
    rm ~/$df
  fi

  ln -s "$PWD/$df" ~/$df
done

echo "dotfiles symlinked successfully..."

# check if homebrew is installed and install it if not
if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  HOMEBREW_PATH=$(["$(uname -p)" == "i386"] && echo "/usr/local/bin" || echo "/opt/homebrew/bin")

  echo "export PATH=$HOMEBREW_PATH:$PATH" >> ~/.zshrc
fi

# update homebrew
brew update

# install homebrew dependencies
brew tap homebrew/bundle
brew bundle
brew cleanup

# check if oh my zsh folder exists and installs it if not
if [ ! -e ~/.oh-my-zsh ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# check if nvm folder exists and installs it if not
if [ ! -e ~/.nvm ]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh)"
fi

# set macOS preferences
$HOME/.dotfiles/macos.sh

echo "finished setup"