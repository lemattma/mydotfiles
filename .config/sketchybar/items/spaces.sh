#!/bin/bash

SPACE_ICONS=("1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12")

# Destroy space on right click, focus space on left click.
# New space by left clicking separator (>)

sid=0
spaces=()

SPACE_BG=0x08ffffff
SPACE_BORDER=0xffff0000
PLUS_ICON_COLOR=$BLUE

for i in "${!SPACE_ICONS[@]}"; do
  sid=$(($i + 1))
  
  space=(
    space="$sid"
    icon="${SPACE_ICONS[i]}"
    icon.padding_left=10
    icon.padding_right=0
    padding_left=2
    padding_right=5
    label.padding_right=20
    icon.highlight_color="$BLUE"
    icon.color="$GREY"
    label.color="$GREY"
    label.highlight_color="$WHITE"
    label.font="sketchybar-app-font:Regular:14.0"
    label.y_offset=-1
    background.color="$SPACE_BG"
    background.border_color="$TRANSPARENT"
    # background.border_width=1
    script="$PLUGIN_DIR/space.sh"
  )
  
  sketchybar --add space space.$sid left \
  --set space.$sid "${space[@]}" \
  --subscribe space.$sid mouse.clicked
done

space_creator=(
  # icon=􀆊
  icon=+
  icon.font="$FONT:Bold:20.0"
  padding_left=4
  padding_right=5
  label.drawing=off
  display=active
  click_script='yabai -m space --create'
  script="$PLUGIN_DIR/space_windows.sh"
  icon.color="$PLUS_ICON_COLOR"
)

sketchybar --add item space_creator left \
--set space_creator "${space_creator[@]}" \
--subscribe space_creator space_windows_change
