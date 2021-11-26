#!/bin/zsh

echo "setting up your MacOS..."

# check if homebrew is installed and install it if not
if test ! $(which brew); then
  /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# update homebrew
brew update

# install homebrew dependencies
brew tap homebrew/bundle
brew bundle
brew cleanup

# check if oh my zsh folder exists and installs it if not
if [ ! -e ~/.oh-my-zsh ]; then
  /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/HEAD/tools/install.sh)"
fi

# check if nvm folder exists and installs it if not
if [ ! -e ~/.nvm ]; then
  /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh)"
fi

dotfiles='.gitconfig .zshrc'

for df in $dotfiles; do
  if [ -e ~/$df ] || [ -L ~/$df ] # file exists or if exists and is a symlink
    rm ~/$df
  fi

  ln -s "$PWD/$df" ~/$df
done

# set macOS preferences
$HOME/.dotfiles/macos.sh

echo "finished setup"