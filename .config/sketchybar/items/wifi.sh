#!/bin/bash

sketchybar --add alias "Control Centre,WiFi" right \
	--rename "Control Centre,WiFi" wifi_alias \
	--set wifi_alias icon.drawing=on \
	label.drawing=off \
	alias.color=$WHITE \
	padding_left=6 \
	background.padding_right=0 \
	background.padding_left=0 \
	width=28 \
	--subscribe wifi_alias wifi_change
