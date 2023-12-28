#!/bin/bash

cd "$(dirname "$0")" || exit

echo "${COL_BLUE}[PWD]${COL_OFF} $(pwd)"

mkdir -p ~/.vim/swaps
mkdir -p ~/.vim/undo
mkdir -p ~/.vim/backups
mkdir -p ~/.tmux/plugins
mkdir -p ~/.config/alacritty/themes
mkdir -p ~/.config/colorize

touch ~/.z

# git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes

# brew install jq
# brew install vim
# brew install tmux
# brew install gotop neofetch # ??
# brew install expect # for unbuffer
# pip install colorize

# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
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
  .gitignore_global
  .irbrc
  .hushlogin
  .yabairc
  .skhdrc
  .fzf.themes.zsh
  .oh-my-zsh/custom/plugins/lemattma
  .config/alacritty/alacritty.toml
  .config/alacritty/alacritty.info
  .config/alacritty/alacritty-bindings.toml
  .config/alacritty/theme-light.toml
  .config/alacritty/theme-dark.toml
  .config/alacritty/toggle-alacritty-theme.sh
  .config/colorize/colorize.conf
  bash-examples.sh
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
  .gitconfig
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
