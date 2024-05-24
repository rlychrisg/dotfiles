#!/bin/bash


mastericon=~/.icons/Vimix-Doder-dark/scalable/devices/audio-speakers.svg
# playericon=~/.icons/Vimix-Doder-dark/scalable/apps/audacious.svg
playericon=~/.icons/Vimix-Doder/scalable@2x/apps/mpv.svg
brightnessicon=~/.icons/Vimix-Doder-dark/16@2x/panel/xfpm-brightness-lcd.svg

case $1 in
    h|help|-h|--help)
        echo "A bunch of media commands all in one place"
        echo "to save from searching several different man"
        echo "pages. "
        echo " "
        echo "To use bind a key to the script with the "
        echo "relevant args"
        echo " "
        echo "    md - Master volume up"
        echo "    mu - Master volume down"
        echo "    pp - Cycle pause for media player"
        echo "    pb - Skip back 10s for media player"
        echo "    pf - Skip fwd 10s"
        echo "    pu - player volume up"
        echo "    pd - Player volume down"
        echo "    bu - Brightness up 5%"
        echo "    bd - Brightness down 5%"
        echo " "
        ;;

    md)
        pactl set-sink-volume 0 -2% && \
        dunstify -i ${mastericon} -h \
        string:x-dunst-stack-tag:sysvol -t 3000 \
        "System volume down" \
        "$(pactl get-sink-volume 0 | head -n 1 | awk '{print $5}')"
        ;;

    mu)
        pactl set-sink-volume 0 +2% && \
        dunstify -i ${mastericon} -h \
        string:x-dunst-stack-tag:sysvol -t 3000 \
        "System volume up" \
        "$(pactl get-sink-volume 0 | head -n 1 | awk '{print $5}')"
        ;;

    pp)
        # playerctl -p audacious play-pause && \
        # dunstify -i ${playericon} -h \
        # string:x-dunst-stack-tag:playpause -t 3000 \
        # "Audacious" \
        # "$(playerctl status)"
        echo 'cycle pause' | socat - '/tmp/mpvpod' && \
        dunstify -i ${playericon} -h \
        string:x-dunst-stack-tag:playpause -t 3000 \
        "MPV" \
        "Play/Pause"
        ;;

    pb)
        playerctl -p audacious position 10- && \
        dunstify -i ${playericon} -h \
        string:x-dunst-stack-tag:audseek -t 3000 \
        "Audacious" \
        "<< 10s"
        ;;

    pf)
        playerctl -p audacious position 10+ && \
        dunstify -i ${playericon} -h \
        string:x-dunst-stack-tag:audseek -t 3000 \
        "Audacious" \
        ">> 10s"
        ;;

    pd)
        # playerctl -p audacious volume 0.02- &&
        # dunstify -i ${playericon} -h \
        # string:x-dunst-stack-tag:audvol -t 3000 \
        # "Audacious Volume Down" \
        # "$(playerctl volume | awk '{print $1*100}')"
        echo 'add volume -5' | socat - '/tmp/mpvpod' && \
        dunstify -i ${playericon} -h \
        string:x-dunst-stack-tag:audvol -t 3000 \
        "MPV volume down"
        ;;

    pu)
        # playerctl -p audacious volume 0.02+ && \
        # dunstify -i ${playericon} -h \
        # string:x-dunst-stack-tag:audvol -t 3000 \
        # "Audacious Volume Up" \
        # "$(playerctl volume | awk '{print $1*100}')"
        echo 'add volume 5' | socat - '/tmp/mpvpod' && \
        dunstify -i ${playericon} -h \
        string:x-dunst-stack-tag:audvol -t 3000 \
        "MPV volume up"
        ;;

    bu)
        brightnessctl set 5%+ && \
        dunstify -i ${brightnessicon} -h \
        string:x-dunst-stack-tag:bness -t 3000 \
        "Brightness up" \
        "$(brightnessctl | grep -i "current brightness" | sed 's/.*(//;s/).*//')"
        ;;

    bd)
        brightnessctl set 5%- && \
        dunstify -i ${brightnessicon} -h \
        string:x-dunst-stack-tag:bness -t 3000 \
        "Brightness down" \
        "$(brightnessctl | grep -i "current brightness" | sed 's/.*(//;s/).*//')"
        ;;

esac
