#!/bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/lemattma/mydotfiles/refs/heads/master/first-run.sh)"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install zsh zsh-completions git bash alfred arc mas alacritty vscode cursor

mkdir -p ~/Projects
cd ~/Projects || exit

git clone git@github.com:lemattma/mydotfiles.git
