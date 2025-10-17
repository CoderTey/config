#!/bin/sh
set -eu

terminal="${terminal:-ghostty}"
rofi_flags='-dmenu -i -p "tmux:" -matching fuzzy -no-custom'
repos_dir="$HOME/repos"

if [ ! -d "$repos_dir" ]; then
    echo "No repos directory found at $repos_dir" >&2
    exit 1
fi

mapfile -t configs < <(find "$repos_dir" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort)

configs=("New session" "${configs[@]}")

chosen="$(printf '%s\n' "${configs[@]}" | rofi $rofi_flags || true)"
[ -n "$chosen" ] || exit 0

if [ "$chosen" = "New session" ]; then

    name="$(rofi -dmenu -p 'New session name:' || true)"
    [ -n "$name" ] || exit 0
else
    name="$chosen"
fi

workdir="$repos_dir/$name"

[ -d "$workdir" ] || mkdir -p "$workdir"

if tmux has-session -t "$name" 2>/dev/null; then
    exec "$terminal" -e tmux attach -t "$name"
else
    exec "$terminal" -e tmux new -s "$name" -c "$workdir"
fi

