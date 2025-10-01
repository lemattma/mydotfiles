function kill-by-name() {
  pkill -f "$1"
}

function kill-by-port() {
  lsof -i :"$1" | awk 'NR>1 {print $2}' | xargs kill -9
}

function kill-by-name-and-port() {
  pkill -f "$1"
  lsof -i :"$2" | awk 'NR>1 {print $2}' | xargs kill -9
}

function kill-by-name-and-port-and-kill() {
  ps aux | grep -i "$1" | grep -v grep | awk '{print $2}' | xargs kill -9
}
