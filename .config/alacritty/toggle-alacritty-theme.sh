#!/bin/bash

CONFIG_FILE=$(ls -l ~/.config/alacritty/alacritty.toml | sed -e "s/.*\-> //g")
DARK_THEME="gruvbox_material_medium_dark"
LIGHT_THEME="gruvbox_material_medium_light"

function light() {
  sed -i '' "s/themes\/themes\/.*\.toml/themes\/themes\/$LIGHT_THEME\.toml/" $CONFIG_FILE
  echo "Light theme '$LIGHT_THEME' is now active"
}

function dark() {
  sed -i '' "s/themes\/themes\/.*\.toml/themes\/themes\/$DARK_THEME\.toml/" $CONFIG_FILE
  echo "Dark theme '$DARK_THEME' is now active"
}

function auto() {
  IS_DARK=$(osascript -e "tell application \"System Events\" to tell appearance preferences to get dark mode")

  if [[ $IS_DARK = "true" ]]
  then
    dark
  else
    light
  fi
}

case $1 in
  d)
    dark
    ;;
  l)
    light
    ;;
  *)
    auto
    ;;
esac
