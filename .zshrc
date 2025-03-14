# zmodload zsh/zprof

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="apple"

plugins=(
  z
  git
  rails
  common-aliases
  zsh-autosuggestions # https://github.com/zsh-users/zsh-autosuggestions
  zsh-fzf-history-search # https://github.com/joshskidmore/zsh-fzf-history-search
  zsh-syntax-highlighting # https://github.com/zsh-users/zsh-syntax-highlighting
  lemattma
)

source $ZSH/oh-my-zsh.sh

# Set up fzf key bindings and fuzzy completion
# eval "$(fzf --bash)"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

export EDITOR='vim'

export PATH="$PATH:/Applications/Alacritty.app/Contents/MacOS"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# export PATH="/usr/local/opt/mysql-client/bin:$PATH"
# export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
# export PATH="/usr/local/opt/libpq/bin:$PATH"
# export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

export TERM="tmux-256color"
# export TERM=alacritty
# export TERM=xterm-256color
# export TERM=xterm

# export CLICOLOR=1 # colorized outputs

source ~/.fzf.themes.zsh
export FZF_DEFAULT_COMMAND="rg --files --hidden | grep -v '.git/'"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --reverse"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS -m --height 50% --border"

# source ~/.fzf.zsh

# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"




# unversioned Python aliases
export PATH="/opt/homebrew/opt/python@3.12/libexec/bin:$PATH"

# eval "$(rbenv init - --no-rehash zsh)"
# FPATH=~/.rbenv/completions:"$FPATH"

# 1Passowrd CLI plugins
# source /Users/martin/.config/op/plugins.sh

# Created by `pipx` on 2025-03-04 03:11:39
# export PATH="$PATH:/Users/martin/.local/bin"
# source ~/.venvs/default/bin/activate

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

eval "$(rbenv init - --no-rehash zsh)"

# Docker CLI completions
fpath=(/Users/martin/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# GRC colorize configuration
[[ -f "$HOME/.config/grc/grc.zsh" ]] && source "$HOME/.config/grc/grc.zsh"


# zprof# The following lines have been added by Docker Desktop to enable Docker CLI completions.
