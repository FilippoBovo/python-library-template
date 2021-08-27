#!/usr/bin/env bash
# This is a shell script to run the test suite.

# Allow keyboard interrupt (ctrl-c)
trap ctrl_c INT
function ctrl_c() { printf "\n** Keyboard interrupt\n"; exit 1; }

# Define the root directory
ROOT_DIR="$(dirname "$0")/.."

# Run the unittest test discovery
python -m unittest discover
