#!/usr/bin/env bash
# Sync config files between this repo and their locations on this machine.
#   ./sync.sh push   repo -> destinations (skipped if the destination directory does not exist)
#   ./sync.sh pull   destinations -> repo (skipped if the destination file does not exist)
set -u

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# "repo file|destination path"
MAPPINGS=(
  "herdr.toml|$HOME/.config/herdr/config.toml"
)

mode="${1:-}"
case "$mode" in
  push|pull) ;;
  *) echo "usage: $0 push|pull" >&2; exit 1 ;;
esac

for mapping in "${MAPPINGS[@]}"; do
  repo_file="$repo_dir/${mapping%%|*}"
  dest="${mapping#*|}"

  if [ "$mode" = push ]; then
    if [ ! -f "$repo_file" ]; then
      echo "skip   $repo_file (not in repo)"
    elif [ ! -d "$(dirname "$dest")" ]; then
      echo "skip   $dest (directory does not exist)"
    else
      cp "$repo_file" "$dest" && echo "pushed $repo_file -> $dest"
    fi
  else
    if [ ! -f "$dest" ]; then
      echo "skip   $dest (file does not exist)"
    else
      cp "$dest" "$repo_file" && echo "pulled $dest -> $repo_file"
    fi
  fi
done
