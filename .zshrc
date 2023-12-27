# zmodload zsh/zprof

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# git clone https://github.com/dracula/zsh.git
# cp -r zsh ~/.oh-my-zsh/custom/themes/dracula
# ZSH_THEME="dracula/dracula"
# ZSH_THEME="lemattma"
# ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster"
ZSH_THEME="apple"

# Install custom plugins
# git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm
# git clone https://github.com/mroth/evalcache ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/evalcache
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search

plugins=(
    common-aliases
    z
    zsh-autosuggestions
    zsh-fzf-history-search # https://github.com/joshskidmore/zsh-fzf-history-search
    zsh-syntax-highlighting
    lemattma
)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.UTF-8

export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

export PATH="$PATH:/Applications/Alacritty.app/Contents/MacOS"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
# export PATH="/usr/local/opt/mysql-client/bin:$PATH"
# export PATH="/usr/local/opt/libpq/bin:$PATH"
# export PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"

export TERM=alacritty
# export TERM=xterm-256color
# export TERM=xterm

# export CLICOLOR=1 # colorized outputs

export FZF_DEFAULT_COMMAND="rg --files --hidden | grep -v '.git/'"
export FZF_DEFAULT_OPTS='-m --height 50% --border'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
   --color=fg:#bdae93,bg:#32302f,hl:#83a598
   --color=fg+:#ebdbb2,bg+:#3c3836,hl+:#83a598
   --color=info:#fabd2f,prompt:#fabd2f,pointer:#8ec07c
   --color=marker:#8ec07c,spinner:#8ec07c,header:#83a598'

source ~/.fzf.zsh

# Local config – moved to oh-my-zsh plaugin, extra.zsh
# [[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# zprof
