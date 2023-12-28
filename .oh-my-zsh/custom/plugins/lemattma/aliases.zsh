alias -g C="| tr -d '\n' | pbcopy"
alias -g G="| grep --color=never"
alias -g GC="| grep --color=always"
alias -g EX="| grep -v"
alias -g H="--help"
alias -g H1="| head -n1"

# https://github.com/magmax/colorize
alias -g HL="| colorize"

# https://pygments.org/docs/cmdline/
alias -g PIG="| pygmentize"
alias cc="pygmentize"

# Shortcuts
alias v="vim"
alias vsc='code'
alias eohmy="vsc $HOME/.oh-my-zsh"
alias edot="vsc $(ls -l ~/.zshrc | sed -e "s/.zshrc//g" | sed -e "s/.*\-> //g")"
alias rel="exec zsh"
alias reloadtmux="tmux source ~/.tmux.conf"
alias ww='which'
alias j='just'
alias jj='unbuffer just'
alias al='~/.config/alacritty/toggle-alacritty-theme.sh'
alias brs='brew search'
alias bri='brew install'
alias brf='brew info'
alias brl='brew leaves | xargs brew desc --eval-all'
alias ehosts='sudo vim /etc/hosts'

# List only directories
alias lsd='ls -lah | grep "^d"'

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

# File size
alias fs="stat -f \"%z bytes\""

# copy last command into clipboard
alias c="echo \$(fc -ln -1) | tr -d '\n' | pbcopy"

# MySQL backup
# alias mysql="/usr/local/opt/mysql-client/bin/mysql"
# alias mysqldump="/usr/local/opt/mysql-client/bin/mysqldump"
# alias mysqldumpfull='mysqldump --opt -u root -p --all-databases | gzip > ~/mysql-full-backup-$(date +%F).sql.gz'
