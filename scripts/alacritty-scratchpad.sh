#!/bin/bash
ALACRITTY_MARK="alacritty_scratch"

# Check if Alacritty is running
if ! pgrep -x "alacritty" > /dev/null; then
  # Launch Alacritty, mark it, and make it floating
  alacritty &
  sleep 0.5
  i3-msg "[title="alacritty-scratchpad"] mark $ALACRITTY_MARK, floating enable, resize set 800 600, move position center"
else
  # Check if the window is visible or hidden
  POS=$(i3-msg -t get_tree | jq -r "recurse(.nodes[]?) | select(.marks? | index(\"$ALACRITTY_MARK\")) | .rect | .x, .y")

  if [[ $POS == *"10000"* ]]; then
    # Window is hidden: Move it to the center
    i3-msg "[con_mark=\"$ALACRITTY_MARK\"] move position center"
  else
    # Window is visible: Move it off-screen
    i3-msg "[con_mark=\"$ALACRITTY_MARK\"] move position 10000 10000"
  fi
fi
