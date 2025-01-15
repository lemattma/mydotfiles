#!/bin/bash

# https://www.pluralsight.com/resources/blog/cloud/conditions-in-bash-scripting-if-statements#string-based-conditions

cd `dirname "$0"`

# array of x
files=(.vimrc .zshrc)

# traverse array
# for f in "${files[@]}"
# do
#   # ...
# done

ls -lh ~/$f
ln -sv $(pwd)/$f ~/$f

if [ -n $1 ] # checks for non-empty strings
if [ -z $1 ] # checks for null after expansion, including non-initialised vars

# file based conditions
if [ -d $folder ] # exists and is directory
if [ -e $file ] # file exists
if [ -f $file ] # exists and is a regular file
if [ -L $file ] # symbolic
if [ -h $file ] # symbolic
if [ -s $file ] # non-empty file
if [ -r $file ] # readable
if [ -w $file ] # writeable
if [ -x $file ] # executable
if [ newerfile -nt olderfile ] # was changed more recently; -ot

# readlink -e $pathtofile ????

# Single bracket supports 3 types of conditions
# file based, string based, and arithmetic (numbers)
if [ -f $file ] # -r readable; -L simbolic;
if [ $1 == "this" ]
if [ $1 -eq 0 ] # -ne -eq -gt -ge -lt -le

# -a
if [ $foo -ge 3 -a $foo -lt 10 ]; then

# Double bracket [[ .. ]]
# supports shell globbing (*)
if [[ "$stringvar" == *[sS]tring* ]]; then
# can omit quotes since word splitting is prevented
if [[ $stringvarwithspaces != foo ]]; then
# no filename expansion
if [[ -a *.sh ]]; then
# && ||
if [[ $num -eq 3 && "$stringvar" == foo ]]; then
# regex
if [[ $1 =~ /regex/ ]]; then

# Double parenthesis for arithmetic conditions
if (( $num <= 5 )); then

# Merge multiple audio files
ffmpeg -i "SHAZIA Part 1 audio.wav" -i "SHAZIA Part 1 audio.wav" -i "SHAZIA Part 1 audio.wav" -i "SHAZIA Part 1 audio.wav" \
-filter_complex '[0:0][1:0][2:0][3:0]concat=n=4:v=0:a=1[out]' \
-map '[out]' SHAZIA.wav

# Convert audio wav to mp3
ffmpeg -i ALEXANDER.wav -vn -ar 44100 -ac 2 -b:a 192k ../Compressed/ALEXANDER.mp3

# Merge multiple video files and compress
ffmpeg -v error -stats -y -i "LOUISE Part 1 video.mov" -i "LOUISE Part 2 video.mov" -i "LOUISE Part 3 video.mov" \
-lavfi "[0:v:0][0:a:0][1:v:0][1:a:0][2:v:0][2:a:0]concat=n=3:v=1:a=1[outv][outa]" \
-map "[outv]" -map "[outa]" \
-c:v libx264 -preset fast -crf 22 -c:a aac -b:a 128k Merged/LOUISE.mp4
