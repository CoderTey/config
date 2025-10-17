#!/bin/sh
set -eu

# Set your terminal:
terminal="ghostty"

# Check if ~/repos exists
if [ ! -d "$HOME/repos" ]; then
  echo "No repos directory found at ~/repos"
  exit 1
fi

# Pick repo
configs="$(find "$HOME/repos" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;)"
[ -n "$configs" ] || { echo "No projects found"; exit 0; }

chosen="$(printf '%s\n' $configs | rofi -dmenu -p 'Projects:')"
[ -n "$chosen" ] || exit 0

dir="$HOME/repos/$chosen"

# Nuke any existing terminal (since you only use one)
pkill -x "$terminal" 2>/dev/null || true
sleep 0.1

# Launch a clean terminal: attach if exists, else create
exec "$terminal" -e tmux new-session -As "$chosen" -c "$dir"

