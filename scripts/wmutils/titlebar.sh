#!/bin/mksh
# Adds titlebars to windows using lemonbar
#
# Created by Dylan Araps
# https://github.com/dylanaraps/dotfiles

# Source colors
source ~/dotfiles/scripts/colors/output/colors.sh &

# Height of titlebar
height=30

# Spawn the bar
spawn () {
    # Check to see if titlebar exists and the window isn't a popup or a dock
    if [ ! -f "/tmp/titlebar-$1" ] && [ ! -z $(lsw | grep "$1") ]; then
        # Create array of window info
        winfo=($(wattr xywh $1))
        width=${winfo[2]}
        xoffset=${winfo[0]}
        yoffset=$((${winfo[1]} - height))

        # Fix lemonbar not launching if y=0
        if [ $yoffset -lt $height ]; then
            wmv 0 +$height $1
            yoffset=$((yoffset + height))
        fi

        # launch lemonbar
        # TODO: Fix center/right aligned text because the bar is only sent info once
        #       and on resize the text width isn't updated. This might not be possible
        #       as I'm resizing lemonbar using wtp and lemonbar doesn't update it's size.
        echo "%{l}   %{A:titlebar.sh -k $1 & killwa $1:}x%{A}%{l}" |
        lemonbar -p -n "tbar-$1" -d -g "$width"x"$height"+"$xoffset"+"$yoffset" -B "#$white" -F "#$black" -f "lemon" | mksh &

        # Save window id and titlebar id to a file
        # This is how the bar/titlebar are "grouped"
        sleep .05
        titlewid=($(wattr xyhi $(lsw -o) | grep "$xoffset $yoffset $height"))
        echo "$1 ${titlewid[3]}" > /tmp/titlebar-$1
    fi
}

# Move / Resize the bar
update () {
    # Create array of window info
    winfo=($(wattr xyw $1))

    # Name of bar
    titlewid=($(cat /tmp/titlebar-$1))

    wtp ${winfo[0]} $((${winfo[1]} - height)) ${winfo[2]} $height ${titlewid[1]}
}

# Kill titlebar of focused window
killbar () {
    ps -ef | awk -v name="tbar-$1" '$0 ~ name {print $2}' | xargs kill 2>/dev/null
    rm "/tmp/titlebar-$1"
}

# Usage: titlebar.sh -flag windowid
while getopts "s:u:k:K" opt; do
    case $opt in
        s) spawn $OPTARG ;;
        u) update $OPTARG ;;
        k) killbar $OPTARG ;;
    esac
done