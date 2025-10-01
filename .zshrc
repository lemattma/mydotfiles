# zmodload zsh/zprof

# Disable Oh My Zsh auto-update check to speed up startup
export DISABLE_AUTO_UPDATE="true"
export HOMEBREW_NO_AUTO_UPDATE=1

# Completion system optimization
# Only rebuild completion dump if it doesn't exist or is older than 24 hours
# Use -C to skip security check for faster startup
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit -C -d ~/.zcompdump
else
  compinit -C -d ~/.zcompdump
fi

plugins=(
  z
  git
  # common-aliases  # Heavy startup cost - uncomment if you need all aliases
  zsh-autosuggestions # https://github.com/zsh-users/zsh-autosuggestions
  zsh-fzf-history-search # https://github.com/joshskidmore/zsh-fzf-history-search
  zsh-syntax-highlighting # https://github.com/zsh-users/zsh-syntax-highlighting
  lemattma
)

source $ZSH/oh-my-zsh.sh

# Set up fzf key bindings and fuzzy completion
# eval "$(fzf --bash)"

source ~/.fzf.themes.zsh
# source ~/.fzf.zsh # TODO: error

# GRC colorize configuration
[[ -f "$HOME/.config/grc/grc.zsh" ]] && source "$HOME/.config/grc/grc.zsh"

# Local config
# [[ -f ~/.zshrc.local ]] && source ~/.zshrc.local


# FNM (faster nvm) =============================================================================
# brew install fnm
# Need --use-on-cd for automatic version switching, but optimize by checking if fnm exists
eval "$(fnm env --use-on-cd)"
# if command -v fnm &> /dev/null; then
# fi

# PYTHON =============================================================================
# export PATH=/opt/homebrew/opt/python@3.10/libexec/bin:$PATH
# brew install pyenv pyenv-virtualenv
# python path configured in .zshrc.local
# export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"
# if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi


# Essential aliases (cherry-picked from common-aliases for speed)
alias l='ls -lFh'
alias la='ls -lAFh'
alias ll='ls -l'
alias grep='grep --color'
alias h='history'

# zprof

# pnpm
# export PNPM_HOME="/Users/martin/Library/pnpm"
# case ":$PATH:" in
#   *":$PNPM_HOME:"*) ;;
#   *) export PATH="$PNPM_HOME:$PATH" ;;
# esac
# pnpm end

export PATH="$HOME/.local/bin:$PATH"
