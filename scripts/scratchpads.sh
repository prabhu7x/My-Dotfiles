#!/bin/bash

exec rgr &
sleep 1s &
notify-send -h string:fgcolor:#ffaa7f -t 3000 'ranger moved to scratchpad'
sleep 1s
exec i3-msg [title='rectangleX'] move scratchpad

