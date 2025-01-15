#!/bin/bash

sketchybar --add alias "Control Centre,Sound" right \
	--rename "Control Centre,Sound" volume_alias \
	--set volume_alias icon.drawing=off \
	label.drawing=off \
	alias.color="$WHITE" \
	background.padding_right=0 \
	background.padding_left=0 \
	width=35
