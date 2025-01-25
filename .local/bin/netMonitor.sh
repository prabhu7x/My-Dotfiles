#!/bin/bash

tmux new-session -d -s mysession  # Create a new session named 'mysession'
tmux split-window -v              # Create a horizontal split
tmux send-keys 'sudo bandwhich -t' C-m          # Run 'vim' in the second pane
tmux select-pane -t 0             # Switch to the first pane
tmux send-keys 'sudo bandwhich -p' C-m         # Run 'htop' in the first pane
tmux attach-session -t mysession  # Attach to the session
