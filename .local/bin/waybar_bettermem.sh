#!/bin/bash

## since i can't figure out how to have bar icons for
## swap as well as mem in waybar's built in widget
## i made this. TODO it's been ages, maybe i can do
## that now.

mempc=$(free | grep Mem | awk '{print $3/$2 * 100.0}' | cut -d . -f 1)
swppc=$(free | grep Swap | awk '{print $3/$2 * 100.0}' | cut -d . -f 1)

## converts percentage value into a bar
get_bar_icon() {
    local percentage=${1}
if [ $percentage -le 10 ]; then
    baricon=" "
elif [ $percentage -ge 10 ] && [ $percentage -le 20 ]; then
    baricon="▁"
elif [ $percentage -ge 20 ] && [ $percentage -le 30 ]; then
    baricon="▁"
elif [ $percentage -ge 30 ] && [ $percentage -le 40 ]; then
    baricon="▂"
elif [ $percentage -ge 40 ] && [ $percentage -le 50 ]; then
    baricon="▃"
elif [ $percentage -ge 50 ] && [ $percentage -le 60 ]; then
    baricon="▄"
elif [ $percentage -ge 60 ] && [ $percentage -le 70 ]; then
    baricon="▅"
elif [ $percentage -ge 70 ] && [ $percentage -le 80 ]; then
    baricon="▆"
elif [ $percentage -ge 80 ] && [ $percentage -le 90 ]; then
    baricon="▇"
elif [ $percentage -ge 90 ]; then
    baricon="█"
fi

echo "$baricon"
}

membar=$(get_bar_icon $mempc)
swpbar=$(get_bar_icon $swppc)

echo "${membar}${swpbar}"

