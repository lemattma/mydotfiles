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

idea() {
  INTELLIJ=$(ls -1d /Applications/IntelliJ\ * | tail -n1)

  if ! [[ -z $1 ]]; then
    open -a "$INTELLIJ" "$1"
  else
    open -a "$INTELLIJ"
  fi
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
