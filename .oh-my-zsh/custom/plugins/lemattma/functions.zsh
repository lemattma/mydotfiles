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

# Syntax-highlight JSON strings or files
function json() {
	if [ -p /dev/stdin ]; then
		# piping, e.g. `echo '{"foo":42}' | json`
		python -mjson.tool | pbcopy #| pygmentize -l javascript
	else
		# e.g. `json '{"foo":42}'`
		python -mjson.tool <<< "$*" | pbcopy #| pygmentize -l javascript
	fi

	echo "copied to clipboard!!"
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

function clean_docker(){
  docker images -q --filter dangling=true | xargs docker rmi                                                                                                                                                                          git:(API-810|)
  docker ps -aq --no-trunc | xargs docker rm
}

# function aws_auth(){
#   ENV=${1:=dev}
#   export AWS_PROFILE=${ENV}
#   export AWS_ACCESS_KEY_ID=`aws configure get aws_access_key_id`
#   export AWS_SECRET_ACCESS_KEY=`aws configure get aws_secret_access_key`
#   echo "Current AWS_PROFILE: $AWS_PROFILE"
#   echo "Current AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
# }
