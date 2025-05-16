#!/bin/bash
# Ensure proper environment for terminal programs like ranger
export TERM=xterm-256color
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Optional: source your aliases and PATH if needed
source ~/.bashrc


sleep 2
exec rgr &
sleep 1 
exec i3-msg [title='ranger-fm'] move scratchpad &
sleep 1
exec notify-send -h string:fgcolor:#ffaa7f -t 3000 'ranger moved to scratchpad'

#sleep 5s &
#exec code &
#sleep 2s
##exec i3-msg [class='Code'] 'move container to workspace 2', 'layout tabbed' &
#i3-msg [class=Code] move container workspace 2 &
#notify-send -h string:fgcolor:#ffaa7f -t 3000 'opening Code' &
