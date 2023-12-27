# docker ps -a shows all container, regardless state; default shows running only
alias dck_running="docker ps --format json | jq -r '.Names'"
alias dck_exited="docker ps -a --format json | jq -r 'select(.State == \"exited\") | .Names'"

function clean_docker(){
  docker images -q --filter dangling=true | xargs docker rmi
  docker ps -aq --no-trunc | xargs docker rm
}

function dck_logs() {
  cwd=$(current_wd)
  project=$(docker-compose ls --format json | jq -r '.[].Name' | grep $cwd)
  unbuffer docker-compose -p "$project" logs -ft
}

function dck_inspect() {
  if [[ -z $1 || $1 = "--help" ]] then;
    echo "${COL_CYAN_BOLD}dck_inspect returns a JSON with general info about a container"
    echo "Usage: dck_inspect [container]"
    echo ""

    return
  fi

  docker inspect --type container $1 | \
    jq '.[0] | pick(.HostConfig.PortBindings, .Config.ExposedPorts, .NetworkSettings.Ports, (.NetworkSettings.Networks[] | .Aliases, .Links) )'
}

# Better Docker output
container_name="s/$(current_wd)-//; s/default-[^-]*-//"
message="s/\([^|]*\)\([^{]*\)\(.*\)\(\"message\":\"\([^\"]*\)\"\)\(.*\)/\1\2$COL_OFF\5 \3\6/"
error="s/{\(.*\)\(\"error\":\"\([^\"]*\)\"\)\(.*\)/${COL_RED}(\3)$COL_OFF {\1\4/"
req_method="s/{\(.*\)\(\"request_method\":\"\([^\"]*\)\"\)\(.*\)/$COL_OFF\3 {\1\4/"
req_url="s/{\(.*\)\(\"request_url\":\"\([^\"]*\)\"\)\(.*\)/$COL_OFF\3 {\1\4/"
req_response="s/{\(.*\)\(\"response_status\":\(2..\)\)\(.*\)/${COL_GREEN}\3$COL_OFF {\1\4/"
req="$req_method; $req_url; $req_response"
l_info="s/{\(.*\)\(\"level\":\"\(info\)\"\)\(.*\)/${COL_BLUE}[INFO]${COL_OFF} {\1\4/I"
l_warn="s/{\(.*\)\(\"level\":\"\(warn\)\"\)\(.*\)/${COL_YELLOW}[WARN]${COL_OFF} {\1\4/I"
l_error="s/{\(.*\)\(\"level\":\"\(error\)\"\)\(.*\)/${COL_RED}[ERROR]${COL_OFF} {\1\4/I"
comma="s/,,/,/g; s/{,/{/g"
pipe="s/^\([^|]*\)| /\1/"
json_blob="s/\({.*}\)/$COL_DIM\n\1$COL_OFF\n/g"

alias -g NICE="| sed -e '$container_name; $l_info; $l_warn; $l_error; $error; $message; $req; $comma; $json_blob' "
