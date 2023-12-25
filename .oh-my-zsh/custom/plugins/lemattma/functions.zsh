# Create a new directory and enter it
function mdc() {
	mkdir -p "$@" && cd "$@"
}

# find shorthand
function f() {
    find . -name "$1"
}

# Copy w/ progress
cp_p () {
  rsync -WavP --human-readable --progress $1 $2
}

isrunning() {
  pgrep $1 > /dev/null && echo yes
}

dark() {
  osascript -e "tell application \"System Events\" to tell appearance preferences to set dark mode to true"
  ~/.config/alacritty/toggle-alacritty-theme.sh
}

light() {
  osascript -e "tell application \"System Events\" to tell appearance preferences to set dark mode to false"
  ~/.config/alacritty/toggle-alacritty-theme.sh
}

print_colors() {
  printf "|039| \033[39mDefault \033[m  |049| \033[49mDefault \033[m  |037| \033[37mLight gray \033[m     |047| \033[47mLight gray \033[m\n"
  printf "|030| \033[30mBlack \033[m    |040| \033[40mBlack \033[m    |090| \033[90mDark gray \033[m      |100| \033[100mDark gray \033[m\n"
  printf "|031| \033[31mRed \033[m      |041| \033[41mRed \033[m      |091| \033[91mLight red \033[m      |101| \033[101mLight red \033[m\n"
  printf "|032| \033[32mGreen \033[m    |042| \033[42mGreen \033[m    |092| \033[92mLight green \033[m    |102| \033[102mLight green \033[m\n"
  printf "|033| \033[33mYellow \033[m   |043| \033[43mYellow \033[m   |093| \033[93mLight yellow \033[m   |103| \033[103mLight yellow \033[m\n"
  printf "|034| \033[34mBlue \033[m     |044| \033[44mBlue \033[m     |094| \033[94mLight blue \033[m     |104| \033[104mLight blue \033[m\n"
  printf "|035| \033[35mMagenta \033[m  |045| \033[45mMagenta \033[m  |095| \033[95mLight magenta \033[m  |105| \033[105mLight magenta \033[m\n"
  printf "|036| \033[36mCyan \033[m     |046| \033[46mCyan \033[m     |096| \033[96mLight cyan \033[m     |106| \033[106mLight cyan \033[m\n"
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

# function aws_auth(){
#   ENV=${1:=dev}
#   export AWS_PROFILE=${ENV}
#   export AWS_ACCESS_KEY_ID=`aws configure get aws_access_key_id`
#   export AWS_SECRET_ACCESS_KEY=`aws configure get aws_secret_access_key`
#   echo "Current AWS_PROFILE: $AWS_PROFILE"
#   echo "Current AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
# }

# Benchmark zsh loading time
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}
