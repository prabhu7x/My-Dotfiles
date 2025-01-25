#!/bin/bash

# Check if xprop is installed
if ! command -v xprop &> /dev/null; then
    echo "Error: xprop is not installed. Install it using your package manager."
    exit 1
fi

# Check if xclip is installed
if ! command -v xclip &> /dev/null; then
    echo "Error: xclip is not installed. Install it using your package manager."
    exit 1
fi

# Function to handle user input
get_user_choice() {
    while true; do
        read -p "Do you want to copy the application class name? (y/n): " RESPONSE
        case "$RESPONSE" in
            y|Y) return 0 ;; # Proceed to copy
            n|N) return 1 ;; # Just print
            *) echo "Invalid input. Please enter 'y' or 'n'." ;;
        esac
    done
}

# Prompt the user for confirmation
if get_user_choice; then
    COPY_TO_CLIPBOARD=true
else
    COPY_TO_CLIPBOARD=false
fi

echo "Click on the window to get its class name..."

# Get the WM_CLASS value using xprop
WM_CLASS=$(xprop | grep "WM_CLASS(STRING)")

# Extract the second value (the application class name)
APP_CLASS=$(echo "$WM_CLASS" | awk -F '"' '{print $4}')

# Check if a class name was retrieved
if [ -z "$APP_CLASS" ]; then
    echo "Error: Unable to retrieve the application class name."
    exit 1
fi

# Handle based on user's choice
if $COPY_TO_CLIPBOARD; then
    echo -n "$APP_CLASS" | xclip -selection clipboard
    echo "Application class name copied to clipboard: $APP_CLASS"
    notify-send "Copied to Clipboard"
else
    echo "Application class name: $APP_CLASS"
    notify-send "Application class name: $APP_CLASS"
fi

