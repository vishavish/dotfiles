#!/usr/bin/bash

set -e

HELIX_PATH="$HOME/.config/helix"
I3_PATH="$HOME/.config/i3"
WEZ_PATH="$HOME/.config/wezterm"

dir_exists() {
  if [ ! -d "$1" ]; then
    echo "Creating $1 path..."
    mkdir -p "$1"
    echo "$1 created successfully..."
  fi
}

for path in "$HELIX_PATH" "$I3_PATH" "$WEZ_PATH"; do
  dir_exists "$path"
done

cp -rf ./i3/* "$I3_PATH"
cp -rf ./helix/* "$HELIX_PATH"
cp -rf ./wezterm/* "$WEZ_PATH"
