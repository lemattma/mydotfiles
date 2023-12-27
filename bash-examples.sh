#!/bin/bash

# https://www.pluralsight.com/resources/blog/cloud/conditions-in-bash-scripting-if-statements#string-based-conditions

cd `dirname "$0"`

# array of x
files=(.vimrc .zshrc)

# traverse array
for f in "${files[@]}"
do
  # ...
done

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
