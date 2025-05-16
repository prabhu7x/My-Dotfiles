#!/bin/bash

# Redirect all stdout and stderr to a log file
exec > ~/.startup.log 2>&1
set -x  # Log every command that runs

# Dump environment variables for debugging
env > ~/.startup.env

# Delay to ensure the session is ready
sleep 1

# --- Your Commands Go Below This Line ---

# Example background services (replace/add your real commands)
sleep 5
alacritty --title ranger-fm --class scratchpad -e btop &

# Set wallpaper using feh (replace with your actual wallpaper command)

# Start network applet if needed
#nm-applet &

# Start notification daemon (comment out if already handled)
# dunst &

# Custom scripts
# ~/.config/scripts/some-daemon.sh &

# --- End of Startup Script ---

echo "Startup script completed at $(date)"
