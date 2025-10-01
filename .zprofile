# echo ".zprofile"

export EDITOR='vim'
export LANG=en_US.UTF-8
# export TERM=tmux-256color
# export TERM=alacritty
# export TERM=xterm-256color
# export TERM=xterm
export AWS_PAGER="" # avoid less-like output

eval "$(/opt/homebrew/bin/brew shellenv)"
# eval "$(rbenv init - --no-rehash zsh)"

# export PYENV_ROOT="$HOME/.pyenv"
# [[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
