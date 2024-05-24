#!/bin/bash

# takes the most recent url from the clipboard and
# prompts the user to pick a format and download location

parentdir="$1"

## pick the terminal, just for a progress bar
## TODO make it work for xorg too
if [[ $XDG_SESSION_TYPE == "wayland" ]]; then
    termargs='foot --title=makemefloat'
else
   notify-send "wayland needed" "this script uses cliphist, so.. "
   exit
fi

## function to exit on esc
function if_exit() {
if [[ $1 == "" ]]; then
    exit
fi
}

cd $parentdir

## take url from clip hist
dlurl=$(cliphist list | awk '/https/ {print $2}' | head -n 1)

## choose a format
chosenformat=$(yt-dlp -F $dlurl | grep --color=never -i -E 'webm|mp4|m4a|mp3' \
    | rofi -dmenu -i -theme fullscreen -p 'Choose format ' \
    -mesg 'ID  EXT   RESOLUTION FPS CH |   FILESIZE   TBR PROTO | VCODEC          VBR ACODEC      ABR ASR MORE INFO' | cut -d' ' -f 1)
if_exit "$chosenformat"

## choose a dir
choosedir="$(find ./ -type d | rofi -dmenu -mesg 'Pick a directory or give a name and create a new folder' -p 'DIR ')"
if_exit "$choosedir"
if ! test -d "$choosedir";  then
    mkdir "$choosedir"
    dldir="./$choosedir"
else
    dldir="$choosedir"
fi

## functions to notify when/if completed
function dlcomplete() {
    newfile=$(ls -luth "$choosedir" | head -n 2 | tail -n 1 | cut -d' ' -f 9-)
    notify-send "Download completed - $newfile"
}
function dlfail() {
    notify-send "Download failed $dlurl"
}

## download the file
$termargs yt-dlp -f $chosenformat -P "$dldir" $dlurl && dlcomplete || dlfail


