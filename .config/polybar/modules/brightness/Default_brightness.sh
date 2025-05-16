#!/bin/fish

xrandr --output $MONITOR --brightness 1
notify-send  --replace-id=11 -t 2000 'Brightness set to default'
