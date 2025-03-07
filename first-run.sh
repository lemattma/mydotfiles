#!/bin/bash

if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo >> "/Users/$(whoami)/.zprofile"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "/Users/$(whoami)/.zprofile"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew install zsh zsh-completions git bash alfred arc mas alacritty visual-studio-code cursor

# if [ ! -d ~/Projects ]; then
#   mkdir ~/Projects
# fi

# cd ~/Projects || exit

# git clone git@github.com:lemattma/mydotfiles.git
