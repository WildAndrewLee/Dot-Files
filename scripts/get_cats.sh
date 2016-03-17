#!/bin/bash
# Author: Andrew Lee (WildAndrewLee)
# Downloads a bunch of cat pictures and resizes them for use with i3lock.

API_KEY=NzM4MjY
URL="http://thecatapi.com/api/images/get?format=src&api_key=$API_KEY&type=png"
DIR="$HOME/assets/cats/"

mkdir -p $DIR

for (( x=1; x<= $1; x++))
do
    wget $URL -qO "$DIR$x.png" && convert "$DIR$x.png" -scale 600x400 "$DIR$x.png" > /dev/null && echo "Got picture #$x"
done
