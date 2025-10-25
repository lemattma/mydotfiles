# echo ".zshenv"


export PATH="$PATH:/Applications/Alacritty.app/Contents/MacOS"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
# export PATH="/opt/homebrew/opt/sqlite/bin:$PATH"
export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
# export PATH="/usr/local/opt/mysql-client/bin:$PATH"
# export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
# export PATH="/usr/local/opt/libpq/bin:$PATH"
# export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

# unversioned Python aliases
export PATH="/opt/homebrew/opt/python@3.13/libexec/bin:$PATH"

# export FPATH=~/.rbenv/completions:"$FPATH"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ZSH_THEME="apple"

export FZF_DEFAULT_COMMAND="rg --files --hidden | grep -v '.git/'"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --reverse"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS -m --height 50% --border"
