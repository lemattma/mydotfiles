#!/bin/bash
cd `dirname "$0"`
echo "Switched to: `pwd`"

# git pull
function syncAll() {
  rsync --exclude ".gitignore" --exclude ".git/" --exclude ".DS_Store" --exclude "install.sh" --exclude "README.md" --exclude "iterm2" -av . ~
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  syncAll
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    syncAll
  fi
fi

unset syncAll
