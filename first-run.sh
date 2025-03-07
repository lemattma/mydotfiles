#!/bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/lemattma/mydotfiles/HEAD/first-run.sh)"

echo >> "/Users/$(whoami)/.zprofile"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "/Users/$(whoami)/.zprofile"
eval "$(/opt/homebrew/bin/brew shellenv)"

brew install zsh zsh-completions git bash alfred arc mas alacritty vscode cursor

mkdir -p ~/Projects
cd ~/Projects || exit

git clone git@github.com:lemattma/mydotfiles.git
