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

export NVM_COMPLETION=true
export NVM_LAZY_LOAD=true
export NVM_DIR="/usr/local/opt/nvm/"

# plugins=(git common-aliases z lemattma zsh-nvm evalcache)
plugins=(
    git 
    common-aliases 
    z 
    zsh-autosuggestions
    zsh-syntax-highlighting
    lemattma
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
# export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export PATH="/usr/local/opt/libpq/bin:$PATH"

# eval "$(rbenv init -)"
# _evalcache rbenv init -


export TERM=xterm-256color

export FZF_DEFAULT_COMMAND="rg --files --hidden | grep -v '.git/'"
export FZF_DEFAULT_OPTS='-m --height 50% --border'
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
    --color=fg:#e5e9f0,bg:#2e3340,hl:#81a1c1
    --color=fg+:#e5e9f0,bg+:#3b4252,hl+:#81a1c1
    --color=info:#eacb8a,prompt:#bf6069,pointer:#b48dac
    --color=marker:#a3be8b,spinner:#b48dac,header:#a3be8b'

source ~/.fzf.zsh

alias ctags="`brew --prefix`/bin/ctags"

HOMEBREW_NO_AUTO_UPDATE=1

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

# neofetch

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

