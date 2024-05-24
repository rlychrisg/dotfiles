#!/bin/bash

## a simple shut down menu for rofi
##
## IMPORTANT
## if small theme doesn't exist remove '-theme small ' or it will
## throw an error. OR create it in ~/.config/rofi/small.rasi
## and change the import to whatever theme is named in config.rasi
## and add the following lines.
##
##      @import "name-of-rofi-theme-set-in-config"
##
##      window {
##          width: 500;
##      }

if [[ $1 == "--help" || $1 == "-h" || $1 == "help" || $1 == "h" ]]; then
    echo " "
    echo "    A simple shut down menu"
    echo "    Not designed to be run from the cli, bind it to a key"
    echo " "
    exit
fi


action=$(printf "Log out\nShut Down\nReboot\nCancel" | rofi -dmenu -theme small -l 4)

if [[ $action == "Log out" ]]; then
    confirm=$(printf "No\nYes" | rofi -dmenu -theme small -l 2 -mesg "Are you sure you want to log out?")
    if [[ $confirm == "Yes" ]]; then
        ## might be better to have the intended log out commands for respective wm
        if [[ $DESKTOP_SESSION == "sway" ]]; then
            swaymsg exit
        fi
    else
        exit
    fi

elif [[ $action == "Shut Down" ]]; then
    confirm=$(printf "No\nYes" | rofi -dmenu -theme small -l 2 -mesg "Are you sure you want to shut down?")
    if [[ $confirm == "Yes" ]]; then
        systemctl poweroff
    else
        exit
    fi

elif [[ $action == "Reboot" ]]; then
    confirm=$(printf "No\nYes" | rofi -dmenu -theme small -l 2 -mesg "Are you sure you want to reboot?")
    if [[ $confirm == "Yes" ]]; then
        reboot
    else
        exit
    fi

else
    exit
fi







