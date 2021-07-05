#!/bin/bash
cd `dirname "$0"`
echo "Switched to: `pwd`"

mkdir -p ~/.vim/swaps
mkdir -p ~/.vim/undo
mkdir -p ~/.vim/backups
mkdir -p ~/.tmux/plugins
touch ~/.z

files=(
  .vimrc 
  .zshrc 
  .tmux.conf 
  .ctags.d 
  .gitconfig
  .gitignore_global
  .irbrc
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

    ln -sv $(pwd)/$f ~

  fi
done

