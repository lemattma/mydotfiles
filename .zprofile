# echo ".zprofile"

export EDITOR='vim'
export LANG=en_US.UTF-8
# export TERM=tmux-256color
# export TERM=alacritty
# export TERM=xterm-256color
# export TERM=xterm

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(rbenv init - --no-rehash zsh)"

# Docker CLI completions
fpath=(/Users/martin/.docker/completions $fpath)
autoload -Uz compinit
compinit

# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
