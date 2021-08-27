#!/usr/bin/env bash
# This is a shell script to upgrade the Python libraries.

# Allow keyboard interrupt (ctrl-c)
trap ctrl_c INT
function ctrl_c() { printf "\n** Keyboard interrupt\n"; exit 1; }

# Define the root directory
ROOT_DIR="$(dirname "$0")/.."

# Uninstall all the installed editable local packages
printf "Uninstalling all the installed editable local packages.\n"
pip freeze | grep "#egg=" | xargs echo | sed -E 's/(.*)#egg=(.*)/\2/' | xargs pip uninstall -y

# Uninstall all the installed libraries
printf "\nUninstalling all the installed external libraries.\n"
pip freeze --exclude-editable | xargs pip uninstall -y

# Upgrade pip, setuptools and wheel
printf "\nUpgrading pip, setuptools and wheel.\n"
pip install --upgrade pip setuptools wheel

# Install the latest version of the production libraries (ADD NEW LIBRARIES HERE)
printf "\nInstalling the latest version of the libraries.\n"
pip install --upgrade numpy pandas

# Freeze the libraries and versions in the production requirements file
printf "\nFreezing the libraries and versions in the production requirements file.\n"
pip freeze --exclude-editable > "$ROOT_DIR/requirements.txt"

# Install the latest version of the development libraries (ADD NEW DEV LIBRARIES HERE)
printf "\nInstalling the latest version of the development libraries.\n"
pip install --upgrade isort black flake8 mypy

# Freeze the libraries and versions in the development requirements file
printf "\nFreezing the libraries and versions in the development requirements file.\n"
pip freeze --exclude-editable > "$ROOT_DIR/requirements_dev.txt"

# Reinstall the local packages as editable
printf "\nReinstalling the local packages as editable.\n"
pip install --no-deps --editable .[dev]

# Check that there are no conflicts between the installed libraries
printf "\nChecking that there are no conflicts between the installed libraries.\n"
pip check
