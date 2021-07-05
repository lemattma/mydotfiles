alias -g PBC="| tr -d '\n' | pbcopy"

alias hosts='sudo vim /etc/hosts'

# List only directories
alias lsd='ls -lah | grep "^d"'

# `cat` with beautiful colors. requires Pygments installed.
alias c='colorize'

# Git stuff
alias gundocommit="git reset --soft HEAD^"
alias gupdatecommit="git add . && git commit --amend --no-edit && gpoc"
alias gcom="gco master && git pull origin master"
alias gcod="gco develop && git pull origin develop"
alias gpoc='git push -f origin `git rev-parse --abbrev-ref HEAD`'
alias gsh="git add . && git stash"
alias gshp="git stash pop"
alias gshd="git stash drop"
alias gshl="git stash list"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
# alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache"

# View HTTP traffic
# alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
# alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Recursively delete `.DS_Store` files
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# Shortcuts
alias v="vim"
alias r="rails"
alias vsc='"/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"'

alias eddzsh="vim ~/.zshrc"
alias eddvim="vim ~/.vimrc"
alias eddtmux="vim ~/.tmux.conf"
alias reloadzsh="exec zsh"
alias reloadtmux="tmux source ~/.tmux.conf"

# alias vim="stty stop '' -ixoff ; vim"
# `Frozing' tty, so after any command terminal settings will be restored
# ttyctl -f

# File size
alias fs="stat -f \"%z bytes\""

# Check recursively Ruby syntax
alias checkrb='find . -name "*.rb" -exec ruby -wc {} \; 2>&1 | grep -v "Syntax OK\|: warning:"'

# Docker
alias dockerconf='eval $(docker-machine env default)'

# MySQL backup
alias mysqldumpfull='mysqldump --opt -u root -p --all-databases | gzip > ~/mysql-full-backup-$(date +%F).sql.gz'
