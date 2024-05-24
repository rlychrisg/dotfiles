#!/bin/bash

## a script for downloading podcasts with rofi
## this uses wl-copy so if i go back to xorg it will
## need changing
#
## ALSO make sure the themes are in ~/.config/rofi.
## if not just delete that bit from all the cmds

## change the path for $podcast dir, copy an episode
## link, and rofi will ask to pick a folder and
## rename (optional)

## TODO tidy this up so i can tell wtf is going on


podcastdir=/mnt/pt1/nothome/podcasts
cd $podcastdir


## take url from clipboard
epurl="$(cliphist list | awk '/https/ {print $2}' | head -n 1)"
epurlclean=$(echo $epurl | cut -d'?' -f 1)

## choose the term
if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
    term="foot --title=makemefloat"
else
    notify-send "need wayland" "change it, or use wayland"
    exit
fi

## select a sub dir for the download
feeddir="$(find ./ -type d | rofi -dmenu -i -mesg 'Pick a download dir or type the name of a new one.')"
## if dir doesn't exit, mk it.
if ! test -d "$feeddir";  then
    mkdir "$feeddir"
    dldir="./$feeddir"
# exit if escape
elif [[ $feeddir == "" ]]; then
    exit
fi

podname=$(echo $epurlclean | awk -F'/' '{print $NF}')
## prompt user to confirm name
rename=$(printf "Continue" | rofi -l 1 -dmenu -theme small -mesg "Current name is $podname, enter a new name or hit Enter to continue" -p " ")
if [[ $rename == "Continue" ]]; then
    podname=$(echo $epurlclean | awk -F'/' '{print $NF}')
elif [[ $rename == "" ]]; then
    exit
else
    podname=$(echo $rename)
fi

## download and notify on success or fail
function dlcomplete() {
    notify-send "Download completed $feeddir/$podname"
}
function dlfail() {
    notify-send "Download failed $feeddir/$podname"
}
$term wget --output-document="$feeddir/$podname" $epurl && dlcomplete || dlfail


