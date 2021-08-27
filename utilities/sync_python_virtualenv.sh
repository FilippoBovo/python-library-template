#!/usr/bin/env bash
# This is a shell script to synchronise the Python libraries with those in file requirements_dev.txt.

# Allow keyboard interrupt (ctrl-c)
trap ctrl_c INT
function ctrl_c() { printf "\n** Keyboard interrupt\n"; exit 1; }

if [ "$(pip freeze --exclude-editable)" != "$(cat requirements_dev.txt)" ]
then
  printf "Synchronising libraries. 🔄\n"

  # Uninstall all the installed editable local packages
  printf "\nUninstalling all the installed editable local packages.\n"
  pip freeze | grep "#egg=" | xargs echo | sed -E 's/(.*)#egg=(.*)/\2/' | xargs pip uninstall -y

  # Uninstall all the installed libraries
  printf "\nUninstalling all the installed external libraries.\n"
  pip freeze --exclude-editable | xargs pip uninstall -y

  # Install the development requirements
  printf "\nInstalling the development requirements.\n"
  pip install -r requirements_dev.txt

  # Reinstall the local packages as editable
  printf "\nReinstalling the local packages as editable.\n"
  pip install --no-deps --editable .[dev]

  # Check that there are no conflicts between the installed libraries
  printf "\nChecking that there are no conflicts between the installed libraries.\n"
  pip check
else
  printf "The installed libraries are already synchronised. 👍\n"
fi
