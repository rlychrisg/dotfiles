#!/bin/bash

# a script to move the focus in a given direction
# or move a floating window to a corner of the screen
# TODO maybe make this use relative move instead

moveorfocus() {
    # try to move windo
    # TODO there has to be a better way of checking whether a window is floaty
    if swaymsg move position 1 1; then
        swaymsg resize set $3 ppt $4 ppt
        swaymsg move position $1 ppt $2 ppt
    else
        # if that fails, then focus
        swaymsg focus $5
    fi
}

case $1 in
                 # x y w h direction to focus
    h) moveorfocus 0 0 50 50 left ;;
    j) moveorfocus 0 50 50 50 down ;;
    k) moveorfocus 50 0 50 50 up ;;
    l) moveorfocus 50 50 50 50 right ;;
esac
