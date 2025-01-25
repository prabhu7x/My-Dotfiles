#!/bin/bash

status=$(wifi | awk '{print $3}')

if [ "$status" = "on" ];
then
    exec $HOME/scripts/scan_networks_loader
else
    notify-send -h string:fgcolor:#ff0000 -t 3000 ' wifi blocked '
fi
