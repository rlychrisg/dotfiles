#!/bin/bash

## a custom waybar module that works with my sway scratchpads
## this tracks the three named scratchpads as well as the one
## unnamed one.
##
## in style.css, a little extra padding may need to added to
## either side,since icons take up two spaces.
## in theory, this shouldn't show at all if there is no output
## but a class has been made for "empty"

if swaymsg -t get_tree | grep "app_id.*scratchnote" &> /dev/null; then
    notes="󰠮 "
else
    notes=""
fi
if swaymsg -t get_tree | grep "app_id.*scratchterm" &> /dev/null; then
    term=" "
else
    term=""
fi
if swaymsg -t get_tree | grep "app_id.*scratchedit" &> /dev/null; then
    edit=" "
else
    edit=""
fi
if swaymsg -t get_tree | grep "scratchmisc" &> /dev/null; then
    misc=" "
else
    misc=""
fi

scratchpads="${misc}${term}${edit}${notes}"

if ! [[ $scratchpads == "" ]]; then
    echo "{\"text\":\"${scratchpads}\",\"class\":\"occupied\"}";
else
    echo "{\"text:\":\"\",\"class\":\"empty\"}";
fi


echo "${scratchpads}"
