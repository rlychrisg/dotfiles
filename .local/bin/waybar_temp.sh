#!/bin/bash

## simply temp module because tracking the values
## i want would mean having three widgets

## what qualifies as an emergency
alertlevel=79

## getting the values and making them look nice
fan=$(sensors | grep 'fan' | awk '{printf "%.1f", $2/1000}')
core1=$(cat /sys/devices/platform/coretemp.0/hwmon/hwmon3/temp2_input | cut -c 1,2)
core2=$(cat /sys/devices/platform/coretemp.0/hwmon/hwmon3/temp3_input | cut -c 1,2)


## fan only shows if it's spinning
if [ $fan == 0.0 ]; then
    fan=""
else
    ## leave a leading space to preserve formatting
    fan=" ${fan}k RPM"
fi

if [ $core1 -ge $alertlevel ] || [ $core2 -ge $alertlevel ]; then
    echo "{\"text\":\"${core1}°C ${core2}°C$fan\",\"class\":\"alert\"}";
else
	echo "{\"text\":\"${core1}°C ${core2}°C${fan}\"}";
fi

