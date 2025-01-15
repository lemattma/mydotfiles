#!/bin/bash

cd "$(dirname "$0")" || exit

echo "${COL_BLUE}[PWD]${COL_OFF} $(pwd)"

files=(
  .zprofile
)

for f in "${files[@]}"; do

  # symbolic? skip; if not, backup and create link
  if [[ -h ~/$f ]]; then
    echo "${COL_CYAN}[EXISTS]${COL_OFF} $f"
  else
    # Backup existing
    if [[ -d ~/$f ]] || [[ -f ~/$f ]]; then
      echo "${COL_YELLOW}[BACKUP]${COL_OFF} $f -> $f-backup"
      mv ~/"$f" ~/"$f"-backup
    fi

    # create symbolic links -s symbolic -v verbose
    echo "${COL_GREEN}[LINK]${COL_OFF} $f"
    ln -sv "$(pwd)/$f" ~/"$f"
  fi

done
