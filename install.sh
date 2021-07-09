#!/bin/bash
cd `dirname "$0"`
echo "Switched to: `pwd`"

# mkdir -p ~/.vim/swaps
# mkdir -p ~/.vim/undo
# mkdir -p ~/.vim/backups
touch ~/.z

mkdir -p ~/.tmux/plugins
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# brew install vim
# brew install tmux gotop neofetch
# Font: https://fonts.google.com/specimen/Source+Code+Pro
# brew install --HEAD universal-ctags/universal-ctags/universal-ctags

# Alacritty
# brew install alacritty
# git clone https://github.com/alacritty/alacritty.git
# cd alacritty
# sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
# cd .. && rm -rf alacritty
# defaults write -g CGFontRenderingFontSmoothingDisabled -bool NO
# defaults -currentHost write -globalDomain AppleFontSmoothing -int 2

files=(
  .vimrc 
  .zshrc 
  .tmux.conf 
  .ctags.d 
  .gitconfig
  .gitignore_global
  .irbrc
  .hushlogin
  .yabairc
  .skhdrc
  .oh-my-zsh/custom/plugins/lemattma
  .config/alacritty/alacritty.yml
)

for f in "${files[@]}" 
do
  if [[ -h ~/$f ]]
  then
    ls -lh ~/$f
  else

    if [[ -d ~/$f ]] || [[ -f ~/$f ]]
    then
      echo "Moving folder $f to $f-backup"
      mv ~/$f ~/$f-backup
    fi

    ln -sv $(pwd)/$f ~/$f

  fi
done

