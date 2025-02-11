#!/bin/bash

# Prompt for device name
read -p "Enter the device name: " device_name

# Use Ranger's file selection as input for the file path
file_path="$1"

# Execute kdeconnect command with user input
if kdeconnect-cli --name "$device_name" --share $file_path; then
    notify-send "File shared with device '$device_name' using KDE Connect."
else 
    notify-send --expire-time=5000 --urgency=critical "Couldn't find device: '$device_name'"
fi