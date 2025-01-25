#!/bin/bash

# Ensure trash-cli is installed
if ! command -v trash-put &>/dev/null; then
    echo "Error: trash-cli is not installed. Install it with 'sudo apt install trash-cli' or your package manager."
    exit 1
fi

# Function to confirm deletion
confirm_trash() {
    local item="$1"
    while true; do
        read -p "Are you sure you want to trash '$item'? [y/n]: " choice
        case "$choice" in
            [Yy]* ) return 0 ;;  # User confirmed
            [Nn]* ) return 1 ;;  # User declined
            * ) echo "Please answer y or n." ;;
        esac
    done
}

# Check if at least one item is provided
if [ "$#" -eq 0 ]; then
    echo "Usage: $0 <file_or_directory> [...]"
    exit 1
fi

# Iterate over all arguments (files from Ranger)
for item in "$@"; do
    if [ ! -e "$item" ]; then
        echo "Error: '$item' does not exist. Skipping..."
        continue
    fi

    if confirm_trash "$item"; then
        trash-put "$item"
        echo "'$item' has been moved to trash."
    else
        echo "Skipping '$item'."
    fi
done

