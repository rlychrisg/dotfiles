#!/bin/bash

# A script for handling scratchpads
# three named and one named.
# since it uses app_id, named scratchpads like this
# pretty much only work with foot.
# so i haven't bothered to make it more universal.
# title doesn't work so well since vim and zsh are set
# to use file names and dirs as titles

# to use, bind
# bindsym <keys> <pathtoscript> <app_id|mark> <foot args>

# app_id is used for named scratchpads, and mark is used
# for unnamed scratchpad. maybe i can have two unnamed
# scratchpads using different marks, if i ever feel like
# i need more.

# rules need to be set in ~/.config/sway/config
# for_window [app_id="scratchnote"] floating enabled; move to scratchpad
# for_window [app_id="scratchedit"] floating enabled; move to scratchpad
# for_window [app_id="scratchterm"] floating enabled; move to scratchpad

# SEE ALSO waybar_scratchpads for a module that tracks all scratchpads


function scratchopen() {
    ## if the scratchpad is open, show it
    if ! swaymsg "[app_id=\"$1\"]" scratchpad show &> /dev/null; then
        ## if it isn't, open it and try again
        swaymsg exec "foot --app-id=$1 $2"
        sleep 0.5
        swaymsg "[app_id=\"$1\"]" scratchpad show
    fi
    ## resize it here as doing this with rules doesn't keep the size when showing scratchpad
    swaymsg "[app_id=\"$1\"]" resize set 1500 800 || notify-send "Scratchpad $1" "Failed to open"
}

case $1 in

    scratchnote)
        # open foot in notes dir so i can easily open other notes from within nvim
        scratchopen $1 "--working-directory=/mnt/pt1/nothome/notes nvim index.md"
    ;;

    scratchedit)
        scratchopen $1 "nvim"
    ;;

    scratchterm)
        scratchopen $1
    ;;

    ## unnamed scratchpad
    scratchmisc)
        ## this one works slightly differently
        if ! swaymsg "[con_mark=\"$scratchmisc\"]" scratchpad show &> /dev/null; then
            swaymsg -- mark --add scratchmisc
            swaymsg move to scratchpad
            notify-send "Moved to unnamed scratchpad"
        fi

    ;;
esac
