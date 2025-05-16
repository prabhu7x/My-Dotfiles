#!/bin/bash

# Lock file location
LOCKFILE="/tmp/brightness_workspace.lock"

if [ -e "$LOCKFILE" ] && kill -0 "$(cat "$LOCKFILE")" 2>/dev/null; then
    echo "Script already running."
    exit 1
fi

echo $$ > "$LOCKFILE"

# Clean up lock on exit
trap "rm -f $LOCKFILE" EXIT


notify-send 'adaptive brightness activated' &

monitor=$(xrandr | awk '/ connected/ {print $1; exit}')
# Define brightness values for each workspace
brightness_workspace1=0.7
# brightness_workspace2=0.9
brightness_workspace3=0.7
low=0.6
default_brightness=1.0

# Function to set brightness
set_brightness() {
    xrandr --output $monitor --brightness $1
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
