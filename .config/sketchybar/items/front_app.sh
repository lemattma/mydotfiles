#!/bin/bash

front_app=(
	label.font="$FONT:Black:12.0"
	label.drawing=off
	icon.drawing=on
	# icon.width=20
	# icon.height=20
	icon.background.width=10
	icon.background.height=25
	# icon.background.color=0xfffc5d7c
	icon.background.drawing=on
	icon.background.image.scale=0.7
	display=active
	script="$PLUGIN_DIR/front_app.sh"
	click_script="open -a 'Mission Control'"
	padding_right=0
)

sketchybar --add item front_app left \
	--set front_app "${front_app[@]}" \
	--subscribe front_app front_app_switched
