#!/bin/bash

# Check if xprop is available
if ! command -v xprop &>/dev/null; then
    notify-send "❌ Error" "xprop not found."
    exit 1
fi

# Get the WM_CLASS of the currently focused window
CLASS=$(xprop -id "$(xdotool getwindowfocus)" WM_CLASS | awk -F '"' '{print $(NF-1)}')

# Copy it to clipboard
echo -n "$CLASS" | xclip -selection clipboard

# Optional: notify the user
notify-send "✅ Copied to clipboard" "$CLASS"

