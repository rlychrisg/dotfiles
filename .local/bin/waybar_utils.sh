#!/bin/bash

# a script to bundle together sundry utils - volume, player
# status, backlight and battery. player status only shows
# if ${player} is actually open, so any trailing spaces
# might be there intentionally.

# since playerctl isn't working for me atm i've
# commented that out

## set the playerctl player, and also a bunch of variables
player="audacious"
vol=$(pactl get-sink-volume 0 | head -n 1 | awk '{print $5}')
# pvol=$(playerctl volume | awk '{print $1*100}')
bkl=$(brightnessctl | grep -i "current brightness" | sed "s/.*(//;s/),*//")
bat=$(cat /sys/class/power_supply/BAT0/capacity)

## battery icons. i could probably do this in the waybar
## config one day.
if [ $bat -le 10 ]; then
    baticon="󰂎"
elif [ $bat -ge 11 ] && [ $bat -le 20 ]; then
    baticon="󰁺"
elif [ $bat -ge 21 ] && [ $bat -le 30 ]; then
    baticon="󰁻"
elif [ $bat -ge 31 ] && [ $bat -le 40 ]; then
    baticon="󰁼"
elif [ $bat -ge 41 ] && [ $bat -le 50 ]; then
    baticon="󰁽"
elif [ $bat -ge 51 ] && [ $bat -le 60 ]; then
    baticon="󰁾"
elif [ $bat -ge 61 ] && [ $bat -le 70 ]; then
    baticon="󰁿"
elif [ $bat -ge 71 ] && [ $bat -le 80 ]; then
    baticon="󰂀"
elif [ $bat -ge 81 ] && [ $bat -le 90 ]; then
    baticon="󰂁"
elif [ $bat -ge 91 ] && [ $bat -le 99 ]; then
    baticon="󰂂"
elif [ $bat == 100 ] ; then
    baticon="󰁹"
fi


    # this is useless if playerctl no work
    # if [ playerctl -p ${player} status ]; then
    # # if [[ $(playerctl -p ${player} status) == "No players found" ]]; then
    #   pvolif=""
    # elif [[ $(playerctl -p $player status) == Stopped ]]; then
    #   pvolif=" ${pvol}% "
    # elif [[ $(playerctl -p $player status) == Playing ]]; then
    #   pvolif="󰐊 ${pvol}% "
    # elif [[ $(playerctl -p $player status) == Paused ]]; then
    #   pvolif="󰏤 ${pvol}% "
    # fi

## use the first line if i fix above
# echo "${pvolif} ${vol}  ${bkl} ${baticon} ${bat}%"

## otherwise...
echo " ${vol}  ${bkl} ${baticon} ${bat}%"
