# Create a new directory and enter it
function mdc() {
	mkdir -p "$@" && cd "$@"
}

# find shorthand
function f() {
    find . -name "$1"
}

# cd into whatever is the forefront Finder window.
cdf() {  # short for cdfinder
  cd "`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`"
}

function passwordless() {
  cat ~/.ssh/id_rsa.pub | ssh $1 'cat >> .ssh/authorized_keys'
}

# Start an HTTP server from a directory, optionally specifying the port
function server() {
	local port="${1:-8000}"
	open "http://localhost:${port}/"
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
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

# take this repo and copy it to somewhere else minus the .git stuff.
function gitexport(){
	mkdir -p "$1"
	git archive master | tar -x -C "$1"
}

# get gzipped size
function gz() {
	echo "orig size    (bytes): "
	cat "$1" | wc -c
	echo "gzipped size (bytes): "
	gzip -c "$1" | wc -c
}

# Extract archives - use: extract <file>
# Based on http://dotfiles.org/~pseup/.bashrc
function extract() {
	if [ -f "$1" ] ; then
		local filename=$(basename "$1")
		local foldername="${filename%%.*}"
		local fullpath=`perl -e 'use Cwd "abs_path";print abs_path(shift)' "$1"`
		local didfolderexist=false
		if [ -d "$foldername" ]; then
			didfolderexist=true
			read -p "$foldername already exists, do you want to overwrite it? (y/n) " -n 1
			echo
			if [[ $REPLY =~ ^[Nn]$ ]]; then
				return
			fi
		fi
		mkdir -p "$foldername" && cd "$foldername"
		case $1 in
			*.tar.bz2) tar xjf "$fullpath" ;;
			*.tar.gz) tar xzf "$fullpath" ;;
			*.tar.xz) tar Jxvf "$fullpath" ;;
			*.tar.Z) tar xzf "$fullpath" ;;
			*.tar) tar xf "$fullpath" ;;
			*.taz) tar xzf "$fullpath" ;;
			*.tb2) tar xjf "$fullpath" ;;
			*.tbz) tar xjf "$fullpath" ;;
			*.tbz2) tar xjf "$fullpath" ;;
			*.tgz) tar xzf "$fullpath" ;;
			*.txz) tar Jxvf "$fullpath" ;;
			*.zip) unzip "$fullpath" ;;
			*) echo "'$1' cannot be extracted via extract()" && cd .. && ! $didfolderexist && rm -r "$foldername" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

# List recurively m4a files
function m4afind() {
  find . -name "._*[m4a|mp3]" -type f -ls -delete
  find . -name "*.[itlp|m4v]" -type f -ls -delete
  # find . -name "._*[m4a|mp3]" -type f -ls -delete
  find . -iname "*.m4a" -follow
  cleanup
}

# Convert from m4a to mp3 brew install ffmpeg first
function m4atomp3convert() {
  find . -name "._*[m4a|mp3]" -type f -ls -delete
  find . -name "*.[itlp|m4v]" -type f -ls -delete

  while IFS= read -r -d $'\0' file; do
    printf "Converting $file...\n"
    newfile=$(echo "$file" | sed s/\.m4a/.mp3/)
    printf "Into $newfile...\n"
    ffmpeg -loglevel quiet -y -i "$file" -acodec libmp3lame -ab 320k "$newfile" </dev/null #2>&1 &

    if [[ $1 = true ]]; then
      rm -f "$file"
    fi

    # return
  done < <(find . -iname "*.m4a" -follow -print0)
}

function update_creation_date() {
  for f in $1/*.MOV
  do
    m4v_file=`echo $f | sed 's/\(.*\.\)MOV/\1m4v/'`

    if [ -f "$m4v_file" ]; then
      size=`stat -f "%z" $m4v_file`
      if [ $size != 0 ]; then
        echo "$m4v_file"
        timestamp=`stat -f %B $f`
        timestamp_date=`date -r $timestamp +%Y%m%d%H%M`
        touch -t $timestamp_date $m4v_file
      fi
    fi
  done
}
