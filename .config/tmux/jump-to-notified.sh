#!/bin/sh
for i in $(tmux list-windows -F "#{window_index}"); do
  STYLE=$(tmux show-window-options -t "$i" -v window-status-style 2>/dev/null)
  if echo "$STYLE" | grep -q "fg=red"; then
    tmux select-window -t "$i"
    exit 0
  fi
done
