#!/bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install zsh zsh-completions git bash alfred arc mas

mkdir -p ~/Projects
cd ~/Projects || exit

git clone git@github.com:lemattma/mydotfiles.git
