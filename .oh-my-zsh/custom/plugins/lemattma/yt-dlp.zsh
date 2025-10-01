#!/usr/bin/env zsh

# yt-dlp related functions for YouTube video downloading and processing

function extract_video_id() {
  local url="$1"
  local metadata="$2"
  local video_id

  # Extract from URL using grep and sed
  if echo "$url" | grep -q "youtube.com/watch?v="; then
    video_id=$(echo "$url" | sed 's/.*youtube.com\/watch?v=\([^&]*\).*/\1/')
  elif echo "$url" | grep -q "youtu.be/"; then
    video_id=$(echo "$url" | sed 's/.*youtu.be\/\([^?]*\).*/\1/')
  else
    # Fallback to metadata extraction
    video_id=$(echo "$metadata" | grep -o '"id": *"[^"]*"' | cut -d'"' -f4)
  fi

  # Clean the ID - remove any query parameters or extra characters
  video_id=$(echo "$video_id" | cut -d'?' -f1 | tr -cd '[:alnum:]-_')

  echo "$video_id"
}

function create_safe_dirname() {
  local title="$1"
  local date="$2"
  local video_id="$3"

  # Remove special characters and emojis, preserve spaces
  title=$(echo "$title" | tr -cd '[:alnum:] ._-')

  # Get first 50 characters of title and trim trailing spaces
  local short_title=$(echo "$title" | cut -c 1-50 | sed 's/ *$//')

  # Ensure each component is valid
  local safe_date=${date:-"00000000"}
  local safe_id=${video_id:-"unknown"}
  local safe_title=${short_title:-"untitled"}

  echo "${safe_date}_${safe_id}_${safe_title}"
}

function organize_transcripts() {
  local output_dir="$1"

  # Create transcripts directory if it doesn't exist
  mkdir -p "$output_dir/transcripts"

  # Move any VTT, SRT, or TXT files to transcripts directory
  if find "$output_dir" -maxdepth 1 -type f \( -name "*.vtt" -o -name "*.srt" -o -name "*.txt" \) | grep -q .; then
    echo "📝 Moving transcripts to dedicated folder..."
    find "$output_dir" -maxdepth 1 -type f \( -name "*.vtt" -o -name "*.srt" -o -name "*.txt" \) -exec mv {} "$output_dir/transcripts/" \;

    # Show what files were moved
    echo "📄 Available transcripts:"
    ls -l "$output_dir/transcripts"
    return 0
  fi
  return 1
}

function yt-fix-meta() {
  local url="$1"
  local json=$(yt-dlp --dump-single-json "$url")
  local title=$(echo "$json" | jq -r '.title' | sed 's/: /-/g')
  local json_filename="$title.info.json"
  local video_filename=$(cat $json_filename | \
    jq -r '[.extractor, .title, .release_year, (.categories | join("-")), (.channel // "")] | map(select(length > 0)) | join(" - ")'
  )
    ls "NA - $title".* 2>/dev/null | while read -r file; do
      local new_name="${file#NA - }"
      mv -f "$file" "$new_name"
      echo "📝 Renamed: $file → $new_name"
    done

  ls "$title".* 2>/dev/null | while read -r file; do
    local ext="${file##*.}"
    local new_name="${video_filename}.${ext}"
    mv -f "$file" "$new_name"
    echo "📝 Renamed: $file → $new_name"
    done
}

function yt-meta() {
  local url="$1"
  local json=$(yt-dlp --dump-single-json "$url")
  local title=$(echo "$json" | jq -r '.title' | sed 's/: /-/g')
  local json_filename="$title.info.json"
  local video_filename=$(cat $json_filename | \
    jq -r '[.extractor, .title, .release_year, (.categories | join("-")), (.channel // "")] | map(select(length > 0)) | join(" - ")'
  )
    ls "NA - $title".* 2>/dev/null | while read -r file; do
      local new_name="${file#NA - }"
      mv -f "$file" "$new_name"
      echo "📝 Renamed: $file → $new_name"
    done

  ls "$title".* 2>/dev/null | while read -r file; do
    local ext="${file##*.}"
    local new_name="${video_filename}.${ext}"
    mv -f "$file" "$new_name"
    echo "📝 Renamed: $file → $new_name"
    done
}

function yt() {
  # https://github.com/yt-dlp/yt-dlp?tab=readme-ov-file#output-template-examples

  # Default quality
  local quality="hd"
  local url=""

  # Parse arguments
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --quality=*)
        quality="${1#*=}"
        shift
        ;;
      *)
        url="$1"
        shift
        ;;
    esac
  done

  # Validate input
  if [ -z "$url" ]; then
    echo "❌ Error: Please provide a video URL"
    echo "Usage: yt [--quality=normal|hd|low] <video_url>"
    echo "  --quality=normal  : Standard quality (default)"
    echo "  --quality=hd      : Highest available quality"
    echo "  --quality=low     : Low resolution for faster downloads"
    return 1
  fi

  # Set format based on quality
  local format_selector
  case "$quality" in
    "hd")
      # Highest quality available
      format_selector="bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best"
      ;;
    "low")
      # Low quality for faster downloads
      format_selector="worst[height<=480][ext=mp4]+bestaudio[ext=m4a]/worst[ext=mp4]/worst"
      ;;
    "normal"|*)
      # Standard quality (original behavior)
      format_selector="bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4] / bv*+ba/b"
      ;;
  esac

  local json=$(yt-dlp --dump-single-json "$url")
  local video_filename=$(jq -r '[.extractor, .title, .release_year, (.categories | join("-")), (.channel // "")] | map(select(length > 0)) | join(" - ")' <<< "$json")
  printf '%s\n' "$json" | jq > ~/YouTube/$video_filename.json

  yt-dlp \
  -f "$format_selector" \
  --merge-output-format mp4 \
  --write-subs \
  --sub-langs "en.*,es.*" \
  --convert-subs "vtt" \
  --embed-chapters \
  --embed-thumbnail \
  --cookies-from-browser chrome \
  -o "~/YouTube/$video_filename.%(ext)s" \
  "$url"
}

function yt2() {
  # Speed mode can be: fast, balanced, or accurate
  local speed_mode="balanced"
  local frames_interval=5  # Capture a frame every X seconds

  # Parse options
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --speed=*)
        speed_mode="${1#*=}"
        shift
        ;;
      --frames=*)
        frames_interval="${1#*=}"
        shift
        ;;
      *)
        # Clean URL - remove escaping and extract video ID properly
        url=$(echo "$1" | sed 's/\\//g')
        shift
        ;;
    esac
  done

  # Validate input
  if [ -z "$url" ]; then
    echo "❌ Error: Please provide a video URL"
    echo "Usage: yt2 [--speed=fast|balanced|accurate] [--frames=N] <video_url>"
    echo "  --speed=fast      : Fastest transcription, lower accuracy (tiny model)"
    echo "  --speed=balanced  : Balanced speed/accuracy (base model) [default]"
    echo "  --speed=accurate  : Highest accuracy, slower (medium model)"
    echo "  --frames=N        : Capture a frame every N seconds (default: 5)"
    return 1
  fi

  # First, verify the URL is valid and get basic metadata
  echo "🔍 Validating URL and fetching video information..."

  # Get video info and handle potential errors
  if ! video_json=$(yt-dlp --dump-single-json "$url" 2>/dev/null); then
    echo "❌ Error: Could not fetch video information. Please check the URL."
    return 1
  fi

  # Extract information safely
  local video_id=$(extract_video_id "$url" "$video_json")
  local video_title=$(echo "$video_json" | grep -o '"title": *"[^"]*"' | cut -d'"' -f4)
  local uploader=$(echo "$video_json" | grep -o '"uploader": *"[^"]*"' | cut -d'"' -f4)
  local upload_date=$(echo "$video_json" | grep -o '"upload_date": *"[^"]*"' | cut -d'"' -f4)

  # Validate that we got the required information
  if [ -z "$video_title" ] || [ -z "$video_id" ]; then
    echo "❌ Error: Could not extract video information"
    return 1
  fi

  # Create a safe directory name
  local safe_dirname=$(create_safe_dirname "$video_title" "$upload_date" "$video_id")
  local output_dir=~/YouTube/"$safe_dirname"

  echo "📁 Creating directory: $output_dir"
  echo "🎥 Video ID: $video_id"
  echo "📅 Upload date: $upload_date"
  echo "📝 Title: $video_title"

  mkdir -p "$output_dir"
  mkdir -p "$output_dir/thumbnails"
  mkdir -p "$output_dir/frames"

  # Save the metadata
  echo "$video_json" > "$output_dir/metadata.json"

  # Save original title for reference
  echo "$video_title" > "$output_dir/original_title.txt"

  echo "⬇️  Downloading video and assets..."
  (
    cd "$output_dir" && \
    # First download just the video info to get duration
    video_duration=$(yt-dlp --print duration "$url")
    total_frames=$((video_duration / frames_interval))
    echo "📸 Will capture approximately $total_frames frames (every ${frames_interval}s from ${video_duration}s video)"

    # Download video and extract frames
    yt-dlp \
      -f 'bv*[height<=480]+ba[ext=m4a]/b[ext=mp4] / bv*+ba/b' \
      --merge-output-format mp4 \
      --write-subs \
      --sub-langs "en.*,es.*" \
      --convert-subs "vtt" \
      --write-thumbnail \
      --write-all-thumbnails \
      --convert-thumbnails jpg \
      --output "%(title)s.%(ext)s" \
      --write-info-json \
      --cookies-from-browser chrome \
      "$url"

    # Create frames directory
    mkdir -p frames

    # Extract frames using ffmpeg
    echo "🎬 Extracting frames every ${frames_interval} seconds..."
    ffmpeg -i *.mp4 -vf "fps=1/${frames_interval}" -frame_pts 1 "frames/frame_%d.jpg" 2>/dev/null

    # Move all thumbnails to thumbnails directory
    echo "🖼  Organizing thumbnails and frames..."
    find . -maxdepth 1 -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.webp" \) -exec mv {} thumbnails/ \;

    # Generate contact sheet of frames
    echo "📑 Generating contact sheet of frames..."
    montage frames/*.jpg -tile 5x -geometry +2+2 thumbnails/contact_sheet.jpg 2>/dev/null || true
  )

  # Check if download was successful
  if [ $? -ne 0 ]; then
    echo "❌ Error: Download failed"
    return 1
  fi

  # Move thumbnails to their own directory (only if they exist)
  find "$output_dir" -maxdepth 1 -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.webp" \) -exec mv {} "$output_dir/thumbnails/" 2>/dev/null \;

  # Create a summary file with key information
  cat << EOF > "$output_dir/summary.txt"
Video Information:
----------------
Title: $video_title
ID: $video_id
Uploader: ${uploader:-Unknown}
Upload Date: ${upload_date:0:4}-${upload_date:4:2}-${upload_date:6:2}
URL: $url
EOF

  # After video download, check and organize any downloaded transcripts
  organize_transcripts "$output_dir"

  # Check if we need to generate transcripts with Whisper
  if ! find "$output_dir/transcripts" -type f -name "*.vtt" | grep -q .; then
    echo "🎤 No subtitles found. Using Whisper for transcription..."

    # Find the video file
    video_file=$(find "$output_dir" -maxdepth 1 -name "*.mp4" | head -n 1)

    if [ -n "$video_file" ]; then
      cd "$output_dir"
      source ~/YouTube/whisper-env/bin/activate

      # Call the optimized transcription function
      transcribe_with_whisper "$video_file" "$output_dir" "$speed_mode"

      # Check if transcription was successful and organize the files
      if [ $? -eq 0 ]; then
        echo "✨ Transcription complete!"
        organize_transcripts "$output_dir"
      else
        echo "⚠️  Warning: Transcription may have encountered issues"
      fi

      deactivate
    else
      echo "⚠️  Warning: No video file found for transcription"
    fi
  else
    echo "✅ Using downloaded subtitles"
  fi

  echo "✅ Processing complete. Files saved in: $output_dir"

  # Show final directory structure
  echo "📂 Directory structure:"
  ls -la "$output_dir"
  echo "📂 Thumbnails:"
  ls -la "$output_dir/thumbnails"
  if [ -d "$output_dir/transcripts" ]; then
    echo "📝 Transcripts:"
    ls -la "$output_dir/transcripts"
  fi
  if [ -d "$output_dir/frames" ]; then
    echo "🎬 Frames:"
    ls -la "$output_dir/frames"
  fi
}
