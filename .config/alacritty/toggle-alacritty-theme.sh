CONFIG_FILE=$(readlink ~/.config/alacritty/alacritty.toml)

function light() {
  cp -f ~/.config/alacritty/theme-light.toml ~/.config/alacritty/theme-current.toml
  touch $CONFIG_FILE
  echo "Light theme is now active"
}

function dark() {
  cp -f ~/.config/alacritty/theme-dark.toml ~/.config/alacritty/theme-current.toml
  touch $CONFIG_FILE
  echo "Dark theme is now active"
}

function auto() {
  IS_DARK=$(osascript -e "tell application \"System Events\" to tell appearance preferences to get dark mode")

  if [[ $IS_DARK = "true" ]]; then
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
