#!/bin/bash

exec rgr &
sleep 1s &
notify-send -h string:fgcolor:#ffaa7f -t 3000 'ranger moved to scratchpad'
sleep 1s
exec i3-msg [title='rectangleX'] move scratchpad &

#sleep 5s &
#exec code &
#sleep 2s
##exec i3-msg [class='Code'] 'move container to workspace 2', 'layout tabbed' &
#i3-msg [class=Code] move container workspace 2 &
#notify-send -h string:fgcolor:#ffaa7f -t 3000 'opening Code' &
