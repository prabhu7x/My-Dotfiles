#!/bin/bash

check=$(wifi | awk '{print $3}')

if [ "$check" = "on" ];
then
    wifi off & notify-send -h string:fgcolor:#aa0000 -t 2000 'wifi disabled' & 
else
    wifi on & notify-send -h string:fgcolor:#00aa00 -t 2000 'wifi enabled' &
    nmcli dev wifi rescan &
fi
