#!/bin/fish

xrandr --output HDMI1 --brightness 1
notify-send  --replace-id=11 -t 2000 'Brightness set to default'
