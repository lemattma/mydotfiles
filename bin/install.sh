#!/bin/bash

# if ~/.ssh doesn't exist, exit
if [ ! -d ~/.ssh ]; then
  echo "${HOME}/.ssh doesn't exist"
  exit 1
fi

# install oh-my-zsh if it's not installed
if [ ! -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# install homebrew if it's not installed
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo >> "/Users/$(whoami)/.zshrc"
  # shellcheck disable=SC2016
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "/Users/$(whoami)/.zshrc"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Minimal plugins and packages
brew install git bash mas fzf pygments rbenv python openjdk@21
brew --cask install alacritty font-hack-nerd-font

# Oh My Zsh plugins
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/joshskidmore/zsh-fzf-history-search ~/.oh-my-zsh/custom/plugins/zsh-fzf-history-search

# clone mydotfiles
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

latest_ruby_version=$(rbenv install -l | grep -v - | tail -1)
rbenv install "$latest_ruby_version"
rbenv global "$latest_ruby_version"

gem install colorize
# ruby -e "require 'colorize'; puts 'This is red!'.red; puts 'This is green!'.green"

# tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

./copy-files.sh

if [[ ! -d ~/.config/alacritty/themes ]]; then
  echo "${COL_GREEN}[CLONE]${COL_OFF} alacritty-theme"
  git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
fi
