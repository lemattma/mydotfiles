#!/bin/zsh

QUERY="$1"

REPOS_PATH="${repos_path}"
EDITOR="${editor}"

# Fetch all repository names first
REPOS=$(ls -d "$REPOS_PATH"/*/ | xargs -n 1 basename)

# If user input exists, filter using fzf
if [[ -n "$QUERY" ]]; then
  FILTERED_REPOS=$(echo "$REPOS" | fzf --filter="$QUERY")
else
  FILTERED_REPOS="$REPOS"
fi

# Start JSON output for Alfred
echo '{ "items": ['

FIRST_ITEM=true
echo "$FILTERED_REPOS" | while read -r REPO; do
  # Get the full repo path
  REPO_PATH="$REPOS_PATH/$REPO"
  
  # Add comma if it's not the first item
  if [ "$FIRST_ITEM" = true ]; then
    FIRST_ITEM=false
  else
    echo ","
  fi
  
  # Output JSON for Alfred with modifers
  echo '{
        "title": "'"$REPO"'",
        "subtitle": "Open with '"$EDITOR"'",
        "arg": "'"$REPO_PATH"'",
        "variables": { "repoPath": "'"$REPO_PATH"'" },
        "mods": {
            "alt": {
                "valid": true,
                "subtitle": "Open in Finder",
                "arg": "'"$REPO_PATH"'",
                "variables": { "repoPath": "'"$REPO_PATH"'", "openInFinder": "true" }
            },
            "cmd": {
                "valid": true,
                "subtitle": "Open in Github",
                "arg": "'"$REPO"'",
                "variables": { "repoName": "'"$REPO"'", "openInGH": "true" }
            }
        }
  }'
done

# Close JSON
echo ']}'
