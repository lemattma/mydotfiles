# zmodload zsh/zprof
# echo ".zshrc"

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

source ~/.fzf.themes.zsh
# source ~/.fzf.zsh # TODO: error

# GRC colorize configuration
[[ -f "$HOME/.config/grc/grc.zsh" ]] && source "$HOME/.config/grc/grc.zsh"

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local


# zprof# The following lines have been added by Docker Desktop to enable Docker CLI completions.
