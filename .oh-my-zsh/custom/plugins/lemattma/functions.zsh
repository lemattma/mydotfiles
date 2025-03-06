#!/bin/bash

# Create a new directory and enter it
function mdc() {
  mkdir -p "$@" && cd "$@"
}

# find shorthand
function f() {
  find . -name "$1"
}

isrunning() {
  pgrep $1 > /dev/null && echo yes
}

function current_wd() {
  pwd | sed -e "s/.*\/\(.*\)$/\1/"
}

dark() {
  osascript -e "tell application \"System Events\" to tell appearance preferences to set dark mode to true"
  ~/.config/alacritty/toggle-alacritty-theme.sh
}

light() {
  osascript -e "tell application \"System Events\" to tell appearance preferences to set dark mode to false"
  ~/.config/alacritty/toggle-alacritty-theme.sh
}

dark_mode() {
  osascript -e "tell application \"System Events\" to tell appearance preferences to get dark mode"
}

idea() {
  INTELLIJ=$(ls -1d /Applications/IntelliJ\ * | tail -n1)

  if ! [[ -z $1 ]]; then
    open -a "$INTELLIJ" "$1"
  else
    open -a "$INTELLIJ"
  fi
}

1p() {
  op item list --categories Login --format=json  | jq ".[] | select(.title // \"\" | test(\"$1\"; \"i\"))"
}

# get gzipped size
# function gz() {
#   echo "orig size    (bytes): "
#   cat "$1" | wc -c
#   echo "gzipped size (bytes): "
#   gzip -c "$1" | wc -c
# }

# List recurively m4a files
# function m4afind() {
#   find . -name "._*[m4a|mp3]" -type f -ls -delete
#   find . -name "*.[itlp|m4v]" -type f -ls -delete
#   # find . -name "._*[m4a|mp3]" -type f -ls -delete
#   find . -iname "*.m4a" -follow
#   cleanup
# }

# Convert from m4a to mp3 brew install ffmpeg first
# function m4atomp3convert() {
#   find . -name "._*[m4a|mp3]" -type f -ls -delete
#   find . -name "*.[itlp|m4v]" -type f -ls -delete

#   while IFS= read -r -d $'\0' file; do
#     printf "Converting $file...\n"
#     newfile=$(echo "$file" | sed s/\.m4a/.mp3/)
#     printf "Into $newfile...\n"
#     ffmpeg -loglevel quiet -y -i "$file" -acodec libmp3lame -ab 320k "$newfile" </dev/null #2>&1 &

#     if [[ $1 = true ]]; then
#       rm -f "$file"
#     fi

#     # return
#   done < <(find . -iname "*.m4a" -follow -print0)
# }

# function update_creation_date() {
#   for f in $1/*.MOV
#   do
#     m4v_file=`echo $f | sed 's/\(.*\.\)MOV/\1m4v/'`

#     if [ -f "$m4v_file" ]; then
#       size=`stat -f "%z" $m4v_file`
#       if [ $size != 0 ]; then
#         echo "$m4v_file"
#         timestamp=`stat -f %B $f`
#         timestamp_date=`date -r $timestamp +%Y%m%d%H%M`
#         touch -t $timestamp_date $m4v_file
#       fi
#     fi
#   done
# }

# function update_file_creation_date() {
#   timestamp=`stat -f %B $2`
#   timestamp_date=`date -r $timestamp +%Y%m%d%H%M`
#   touch -t $timestamp_date $1
# }

# Benchmark zsh loading time
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

function snippet-add() {
  uuid1=$(uuidgen)
  uuid2=$(uuidgen)

  word=$(echo $1 | awk '{print tolower($0)}')
  abbr=$(echo $2 | awk '{print tolower($0)}')

  first=${word:0:1}
  firstUpper=$(echo $first | awk '{print toupper($0)}')
  rest=${word:1}

  abbrfirst=${abbr:0:1}
  abbrfirstUpper=$(echo $abbrfirst | awk '{print toupper($0)}')
  abbrrest=${abbr:1}

  basePath=~/Dropbox/_APPFILES/Alfred/Alfred.alfredpreferences/snippets/WORDS/

  filename1=$basePath/$first$rest\ \[$uuid1\].json
  filename2=$basePath/$firstUpper$rest\ \[$uuid2\].json

  echo "{\"alfredsnippet\": {\"snippet\": \"$first$rest\", \"uid\": \"$uuid1\", \"name\": \"$first$rest\", \"keyword\": \"$abbrfirst$abbrrest\"}}" > $filename1

  echo "{\"alfredsnippet\": {\"snippet\": \"$firstUpper$rest\", \"uid\": \"$uuid2\", \"name\": \"$firstUpper$rest\", \"keyword\": \"$abbrfirstUpper$abbrrest\"}}" > $filename2

  echo "✅ $abbrfirst$abbrrest -> $first$rest"
  echo "✅ $abbrfirstUpper$abbrrest -> $firstUpper$rest"
  echo "Done."
}

function psf() {
  # https://www.shortcutfoo.com/app/dojos/awk/cheatsheet
  # rmam is to disable automatic margins
  # tput rmam

  # NR>1 is to skip the first line
  ps -meo start,pid,cpu,%cpu,%mem,rss,command | grep -v "0.0  0.0" \
  | awk 'NR>1{gsub($6, int($6/1024)"M")} {print $0"\n"}'

  # smam is to enable automatic margins
  # tput smam
}

function pss() {
  # l_error="s/{\(.*\)\(\"level\":\"\(error\)\"\)\(.*\)/${COL_RED}[ERROR]${COL_OFF} {\1\4/I"
  # micros_log_parser="$container_name; $l_info; $l_warn; $l_error; $error; $message; $req; $comma; $json_blob"
  # alias -g MIC="| sed -e '$micros_log_parser' "

  psf \
  | sed -r 's/(.+? )(.*fnm\/.+?)(\/bin.+)/\1\3/; s/(.+)( .*node_modules)(.*)/__\1 node_modules\3/' \
  | grep -v "0.0  0.0" \
  | grep -v "sed "

}

function find_and_run() {
  echo "Finding $2 in $1 and running $3"
  # -print0 and -0 go together to handle spaces in filenames
  # -L1 is to run one process at a time
  # -P0 is to run as many processes as possible
  # -iname is case insensitive
  find $1 -type f -iname $2 -print0 | xargs -0 -L1 -P0 $3
}

function yt() {
  # https://github.com/yt-dlp/yt-dlp?tab=readme-ov-file#output-template-examples

  # --embed-subs
  # --split-chapters
  # --keep-video \
  # -o ~/YouTube/%(title)s.%(ext)s
  yt-dlp \
  -f "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4] / bv*+ba/b" \
  --merge-output-format mp4 \
  --write-subs \
  --sub-langs "en.*,es.*" \
  --convert-subs "vtt" \
  --embed-chapters \
  --embed-thumbnail \
  -o "~/YouTube/%(channel)s - %(title)s.%(ext)s" \
  $1
}

function yb_windows() {
  printf "\n"

  # Initialize filters
  local filter_app=""
  local filter_title=""

  # Parse arguments
  for arg in "$@"; do
    case "$arg" in
      app=*) filter_app="${arg#*=}" ;;
      title=*) filter_title="${arg#*=}" ;;
    esac
  done

  # Construct jq filter dynamically
  local jq_filter="sort_by(.app)[]"
  local conditions=()

  [[ -n "$filter_app" ]] && conditions+=(".app | test(\"$filter_app\"; \"i\")")
  [[ -n "$filter_title" ]] && conditions+=(".title | test(\"$filter_title\"; \"i\")")

  [[ ${#conditions[@]} -gt 0 ]] && jq_filter+=" | select(${conditions[*]})"

  # Column headers
  local -r headings="APP,TITLE,FLOATING,HIDDEN,MINIMIZED,NATIVE FULLSCREEN,STICKY,VISIBLE"
  # local -r headings="APP,TITLE,FLOATING,HIDDEN,MINIMIZED,NATIVE FULLSCREEN,STICKY,VISIBLE"


  # Define jq fields (with consistent boolean formatting)
  local -r fields='
    .app,
    .title,
    (if ."is-floating" then "✔" else "✗" end),
    (if ."is-hidden" then "✔" else "✗" end),
    (if ."is-minimized" then "✔" else "✗" end),
    (if ."is-native-fullscreen" then "✔" else "✗" end),
    (if ."is-sticky" then "✔" else "✗" end),
    (if ."is-visible" then "✔" else "✗" end)
  '

  # Run yabai query and format as CSV
  (echo "$headings"; yabai -m query --windows | jq -r "$jq_filter | [ $fields ] | @csv" | sed 's/\xe2\x80\x8e//g') | csvlook

  printf "\n"
}

function yb_attributes() {
  echo "\n"
  yabai -m query --windows | jq -r 'map(keys) | add | unique | unique';
  echo "\n"
}

urldecode() {
  if [ -t 0 ]; then
    # Case: Argument provided
    python3 -c "import sys, urllib.parse; print(urllib.parse.unquote(sys.argv[1]))" "$1"
  else
    # Case: Input received via pipe
    python3 -c "import sys, urllib.parse; print(urllib.parse.unquote(sys.stdin.read().strip()))"
  fi
}

git_status_all() {
  for dir in $1; do
    status_output=$(cd "$dir" && git status --short)

    if [ -n "$status_output" ]; then
      echo "📂 $dir"
      echo "$status_output"
      echo ""
    fi
  done
}