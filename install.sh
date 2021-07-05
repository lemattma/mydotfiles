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

files=(
  .vimrc 
  .zshrc 
  .tmux.conf 
  .ctags.d 
  .gitconfig
  .gitignore_global
  .irbrc
  .hushlogin
  .oh-my-zsh/custom/plugins/lemattma
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

