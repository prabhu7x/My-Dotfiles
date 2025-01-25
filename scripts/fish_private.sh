#!/bin/sh

# Check if already in Fish private mode
if [[ "$SHELL" == *"fish"* && "$FISH_PRIVATE_MODE" == "1" ]]; then
  # Exit Fish private mode
  exit
else
  # Enter Fish private mode
  fish -P && notify-send 'Fish Private mode'
fi
