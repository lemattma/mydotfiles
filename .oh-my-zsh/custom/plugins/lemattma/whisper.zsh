#!/bin/bash

# Whisper-related functions for macOS

function check_whisper_model() {
  local model_name="$1"
  local cache_dir="$HOME/.cache/whisper"
  local model_path="$cache_dir/$model_name.pt"

  if [ ! -f "$model_path" ]; then
    echo "⬇️  Downloading Whisper $model_name model (this may take a while)..."
    return 1
  fi
  return 0
}

# Check if GPU acceleration is available for Whisper on macOS
function check_gpu_available() {
  # MPS is currently disabled due to PyTorch compatibility issues with Whisper
  echo "💻 Using CPU for reliable transcription (optimized for Apple Silicon)" >&2
  echo "cpu"
  return 1
}

# Whisper transcription with configurable options for speed vs accuracy
function transcribe_with_whisper() {
  local video_file="$1"
  local output_dir="$2"
  local speed_mode="${3:-balanced}" # fast, balanced, or accurate

  local model
  local transcribe_status

  # Ensure we're in the whisper environment
  echo "🔧 Setting up Whisper environment..."
  if [ -d "$HOME/YouTube/whisper-env" ]; then
    source "$HOME/YouTube/whisper-env/bin/activate"
    echo "✓ Whisper environment activated"
  else
    echo "⚠️ Whisper environment not found at $HOME/YouTube/whisper-env"
    echo "   Transcription will use system Python (may not have GPU support)"
  fi

  # Set device to CPU (optimized for Apple Silicon)
  check_gpu_available  # This just prints the status message

  case "$speed_mode" in
    "fast")
      # Fastest but less accurate
      model="tiny"
    ;;
    "balanced")
      # Good balance between speed and accuracy
      model="base"
    ;;
    "accurate")
      # Most accurate but slowest
      model="medium"
    ;;
    *)
      model="base"
    ;;
  esac

  echo "🎯 Starting transcription using ${speed_mode} mode (${model} model) on CPU..."

  # Check if Whisper model is available
  if ! check_whisper_model "$model"; then
    echo "🔄 This may take a few minutes on first run..."
    echo "💡 Tip: The model will be cached for future use"
  else
    echo "✓ Using cached Whisper model"
  fi

  # Execute transcription optimized for Apple Silicon CPU
  echo "🚀 Starting transcription..."
  whisper "$video_file" \
  --model "$model" \
  --output_dir "$output_dir" \
  --device cpu \
  --fp16 False \
  --language en \
  --output_format all \
  --verbose False \
  --condition_on_previous_text False \
  --threads "$(sysctl -n hw.ncpu)"
  transcribe_status=$?

  # Check if transcription was successful by looking for output files
  if [ $transcribe_status -eq 0 ] && { [ -f "$output_dir"/*.txt ] || [ -f "$output_dir"/*.vtt ] || [ -f "$output_dir"/*.srt ]; }; then
    echo "✨ Transcription completed successfully!"

    # Move transcription files to a dedicated directory
    mkdir -p "$output_dir/transcripts"
    find "$output_dir" -maxdepth 1 -type f \( -name "*.vtt" -o -name "*.srt" -o -name "*.txt" \) -exec mv {} "$output_dir/transcripts/" \;

    # Show what files were generated
    echo "📝 Generated transcripts:"
    ls -l "$output_dir/transcripts"
    return 0
  else
    echo "❌ Transcription failed to generate output files"
    return 1
  fi
}

function whis() {
  cd ~/YouTube || exit
  source whisper-env/bin/activate

  transcribe_with_whisper "$1" "."
}
