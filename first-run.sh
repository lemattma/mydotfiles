#!/bin/bash

if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo >> "/Users/$(whoami)/.zprofile"
  # shellcheck disable=SC2016
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "/Users/$(whoami)/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew install zsh zsh-completions git bash mas

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

if [ ! -d ~/Projects/mydotfiles ]; then
  mkdir -p ~/Projects
  cd ~/Projects || exit
  git clone git@github.com:lemattma/mydotfiles.git
fi

cd ~/Projects/mydotfiles || exit
./install.sh
./install-mas.sh
./osx-settings.sh

brew bundle install --file ~/Brewfile
brew cleanup
brew doctor