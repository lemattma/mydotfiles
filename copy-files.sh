#!/bin/bash

cd "$(dirname "$0")" || exit

echo "${COL_BLUE}[PWD]${COL_OFF} $(pwd)"


files=(
  # .vimrc
  .zshrc
  .tmux.conf
  # .ctags.d
  .gitignore_global
  .irbrc
  .hushlogin
  # .yabairc
  # .skhdrc
  .fzf.themes.zsh
  .oh-my-zsh/custom/plugins/lemattma
  .config/alacritty/alacritty.toml
  .config/alacritty/alacritty.info
  .config/alacritty/alacritty-bindings.toml
  .config/alacritty/theme-light.toml
  .config/alacritty/theme-dark.toml
  .config/alacritty/toggle-alacritty-theme.sh
  .config/colorize/colorize.conf
  .config/karabiner
  .grc/grc.conf
  # bash-examples.sh
  Brewfile
  .gitconfig
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

# files that could change due to local configs, don't link; just copy
files=(
  .dark_mode
  .config/alacritty/theme-current.toml
)

for f in "${files[@]}"; do
  
  if [[ -e ~/$f ]]; then
    echo "${COL_CYAN}[EXISTS]${COL_OFF} $f"
  else
    cp "$(pwd)/$f" ~/"$f"
    echo "${COL_GREEN}[COPY]${COL_OFF} $f"
  fi
  
done
