#!/usr/bin/env bash
# This formats the code to be (partially) PEP8 compliant.

# Allow keyboard interrupt (ctrl-c)
trap ctrl_c INT
function ctrl_c() { printf "\n** Keyboard interrupt\n"; exit 1; }

# Sort imports
printf "Sorting the imports (isort).\n"
isort .

# Style the code
printf "\nStyling the code (black).\n"
black --line-length 120 .
