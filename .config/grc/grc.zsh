# GRC colorize for zsh
# Source this file from your .zshrc

# Check if grc is installed
if (( $+commands[grc] )); then
  # Set GRC_CONF_DIR to use our custom configurations
  export GRC_CONF_DIR="$HOME/.config/grc"
  
  # Define aliases for common commands
  alias colourify="grc -es --colour=auto"
  
  # System commands
  alias ping="colourify ping"
  alias traceroute="colourify traceroute"
  alias dig="colourify dig"
  alias mount="colourify mount"
  alias df="colourify df"
  alias ifconfig="colourify ifconfig"
  alias ip="colourify ip"
  alias netstat="colourify netstat"
  alias ps="colourify ps"
  alias top="colourify top"
  
  # Development tools
  alias gcc="colourify gcc"
  alias g++="colourify g++"
  alias make="colourify make"
  alias diff="colourify diff"
  alias wdiff="colourify wdiff"
  
  # Docker commands
  alias docker="colourify docker"
  alias docker-compose="colourify docker-compose"
  
  # Git commands
  alias git="colourify git"
  
  # Logs and monitoring
  alias tail="colourify tail"
  alias head="colourify head"
  alias cat="colourify cat"
  
  # Package management
  alias brew="colourify brew"
  
  # Only alias these if they exist on the system
  (( $+commands[apt] )) && alias apt="colourify apt"
  (( $+commands[dpkg] )) && alias dpkg="colourify dpkg"
  (( $+commands[systemctl] )) && alias systemctl="colourify systemctl"
  (( $+commands[journalctl] )) && alias journalctl="colourify journalctl"
  (( $+commands[tcpdump] )) && alias tcpdump="colourify tcpdump"
  (( $+commands[nmap] )) && alias nmap="colourify nmap"
  (( $+commands[cvs] )) && alias cvs="colourify cvs"
  
  # You can add more aliases here as needed
fi
