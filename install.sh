#!/bin/bash

cd "$(dirname "$0")" || exit

echo "${COL_BLUE}[PWD]${COL_OFF} $(pwd)"

# mkdir -p ~/.vim/swaps
# mkdir -p ~/.vim/undo
# mkdir -p ~/.vim/backups
mkdir -p ~/.tmux/plugins
mkdir -p ~/.config/alacritty/themes
mkdir -p ~/.config/colorize
mkdir -p ~/.grc

touch ~/.z

git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
git clone https://github.com/joshskidmore/zsh-fzf-history-search "${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# brew install gotop neofetch # ??
# pip install colorize

# Font: https://fonts.google.com/specimen/Source+Code+Pro
# brew install --HEAD universal-ctags/universal-ctags/universal-ctags

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

# vim +PluginInstall +qall
