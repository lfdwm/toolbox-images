#!/bin/bash

VST_DIR="$HOME/Music/VSTs (Win)/"

if [ ! -f /run/.toolboxenv ]; then
  echo "Not running in a toolbox container! Exiting..."
  exit 1
fi

# Set up wineprefix
toolbox_name=$(awk -F'"' '/^name=/{print $2}' /run/.containerenv 2>/dev/null)
mkdir -p "$HOME/local/share/wine-prefixes/$toolbox_name"
export WINEPREFIX="$HOME/.local/share/wine-prefixes/$toolbox_name"

# Make sure yabridge is synced up
yabridgectl add "$VST_DIR"
yabridgectl sync

# Start bitwig
bitwig-studio
