#!/bin/fish

set brightness (xrandr --verbose | grep -i brightness | awk '{print $2}')

set increase (math $brightness + 0.1)

set percentage (math "floor($brightness/1.5*100)")

if test $increase -le 1.5
    xrandr --output HDMI1 --brightness $increase
    notify-send --replace-id=11 -t 2000 " Brightness $percentage%  "
else 
    notify-send --replace-id=11 -t 2000 " Brightness Restricted "
end
