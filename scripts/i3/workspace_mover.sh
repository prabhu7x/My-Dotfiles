#!/bin/bash

sleep 8s
i3-msg [class='Code'] 'move container to workspace 2', 'layout tabbed' &
notify-send -h string:fgcolor:#ffaa7f -t 3000 'Moving Code to workspace 2' &
