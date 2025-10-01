function fancy-md() {
  local theme=${1:-"nord"}  # Default to nord if no theme specified
  local input_file=${2:-"TREE_HUGGER.md"}  # Default input file
  local output_file="${input_file%.*}-${theme}.html"  # Generate output filename

  local styles=""
  # Common styles for both themes
  local base_styles='
      @import url("https://fonts.googleapis.com/css2?family=Noto+Sans:wght@400;700&family=Inconsolata:wght@400;700&display=swap");
      body { font-family: "Noto Sans", sans-serif; max-width: 800px; margin: 0 auto; padding: 20px; }
      pre, code { font-family: "Inconsolata", monospace; }
      pre { padding: 1em; border-radius: 4px; }'

  if [ "$theme" = "catpuccin" ]; then
    styles="<style>
      ${base_styles}
      body { background-color: #24273a; color: #cad3f5; }
      pre { background-color: #363a4f; }
      code { color: #8aadf4; }
      h1, h2, h3 { color: #8aadf4; }
      a { color: #7dc4e4; }
      ::selection { background-color: #494d64; }
    </style>"
  else
    styles="<style>
      ${base_styles}
      @import url('https://unpkg.com/nord-highlightjs@0.1.0/dist/nord.css');
      body { background-color: #2e3440; color: #d8dee9; }
      pre { background-color: #3b4252; }
      code { color: #88c0d0; }
      h1, h2, h3 { color: #81a1c1; }
      a { color: #88c0d0; }
    </style>"
  fi

  echo "$styles" > github.css
  pandoc "$input_file" \
    --standalone \
    --metadata title="Tree Hugger Guide" \
    -c github.css \
    --include-in-header=github.css \
    -o "$output_file"
}
