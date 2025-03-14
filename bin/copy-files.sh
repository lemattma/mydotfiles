#!/bin/bash

# Move to the root directory of the project
cd "$(dirname "$0")/.." || exit

files=(
  .zshrc
  .tmux.conf
  .gitignore_global
  .irbrc
  .hushlogin # silence terminal login
  .yabairc
  .skhdrc
  .fzf.themes.zsh
  .oh-my-zsh/custom/plugins/lemattma
  .config/alacritty
  .config/colorize
  .config/nvim
  .config/karabiner
  .config/grc
  Brewfile
  # Git
  .gitconfig
  .gitignore
  .gitignore_global
)

for f in "${files[@]}"; do
  
  # symbolic? skip; if not, backup and create link
  if [[ -h ~/$f ]]; then
    echo "${COL_BLACK}[EXISTS] $f ${COL_OFF}"
  else
    # Backup existing
    if [[ -d ~/$f ]] || [[ -f ~/$f ]]; then
      echo "${COL_YELLOW} [BACKUP]${COL_OFF} $f -> $f-backup"
      mv ~/"$f" ~/"$f"-backup
    fi
    
    # create symbolic links -s symbolic -v verbose
    echo "${COL_GREEN}  [LINK]${COL_OFF} $f"
    ln -s "$(pwd)/$f" ~/"$f"
    # ln -sv "$(pwd)/$f" ~/"$f"
  fi
  
done

# files that could change due to local configs, don't link; just copy
files=(
  .dark_mode
  .config/alacritty/theme-current.toml
)

for f in "${files[@]}"; do
  
  if [[ -e ~/$f ]]; then
    echo "${COL_BLACK}[EXISTS] $f ${COL_OFF}"
  else
    cp "$(pwd)/$f" ~/"$f"
    echo "${COL_GREEN}  [COPY]${COL_OFF} $f"
  fi
  
done
