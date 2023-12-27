CONFIG_FILE=$(readlink ~/.config/alacritty/alacritty.toml)

function light() {
  cp -f ~/.config/alacritty/theme-light.toml ~/.config/alacritty/theme-current.toml
  echo "Light theme is now active"
  refresh "false"
}

function dark() {
  cp -f ~/.config/alacritty/theme-dark.toml ~/.config/alacritty/theme-current.toml
  echo "Dark theme is now active"
  refresh "true"
}

function refresh() {
  echo "$1" > ~/.dark_mode
  touch $CONFIG_FILE
  exec zsh
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
