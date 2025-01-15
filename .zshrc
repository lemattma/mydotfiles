# zmodload zsh/zprof

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="apple"

plugins=(
  z
  git
  rails
  common-aliases
  zsh-autosuggestions
  zsh-fzf-history-search # https://github.com/joshskidmore/zsh-fzf-history-search
  zsh-syntax-highlighting
  lemattma
)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

export EDITOR='vim'

export PATH="$PATH:/Applications/Alacritty.app/Contents/MacOS"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
# export PATH="/usr/local/opt/mysql-client/bin:$PATH"
# export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
# export PATH="/usr/local/opt/libpq/bin:$PATH"
# export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

export TERM=alacritty
# export TERM=xterm-256color
# export TERM=xterm

# export CLICOLOR=1 # colorized outputs

export FZF_DEFAULT_COMMAND="rg --files --hidden | grep -v '.git/'"
export FZF_DEFAULT_OPTS='-m --height 50% --border' # --border

source ~/.fzf.themes.zsh
# source ~/.fzf.zsh

# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# zprof


# export PATH="/Users/mmiranda/.local/bin:$PATH"

# unversioned Python aliases
# export PATH="/usr/local/opt/python@3.12/libexec/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.12/libexec/bin:$PATH"

eval "$(rbenv init - --no-rehash zsh)"
FPATH=~/.rbenv/completions:"$FPATH"
autoload -U compinit
compinit

# 1Passowrd CLI plugins
source /Users/martin/.config/op/plugins.sh
