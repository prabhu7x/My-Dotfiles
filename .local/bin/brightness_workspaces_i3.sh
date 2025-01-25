#!/bin/bash

notify-send 'adaptive brightness activeted' &

# Define brightness values for each workspace
brightness_workspace1=0.7
# brightness_workspace2=0.9
brightness_workspace3=0.7
low=0.6
default_brightness=1.0

# Function to set brightness
set_brightness() {
    xrandr --output HDMI1 --brightness $1
}

# Initialize the brightness to the default value
set_brightness $default_brightness

# Monitor for workspace changes
i3-msg -t subscribe -m '[ "workspace" ]' | while read -r line ; do
    current_workspace=$(i3-msg -t get_workspaces | jq -r '.[] | select(.visible == true).num')

    case $current_workspace in
        1)
            set_brightness $brightness_workspace1
            ;;
        # 2)
        #     set_brightness $brightness_workspace2
        #     ;;
        3)
            set_brightness $brightness_workspace3
            ;;
        5)
            set_brightness $low
            ;;
        *)
            set_brightness $default_brightness
            ;;
    esac
done