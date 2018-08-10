#!/bin/bash

if [ ! -d "$1" ]; then
  printf "Directory does not exists: $1"
  exit 1
fi

declare -a array=()
# =============================================================== #
# Get files from the directory
# =============================================================== #
BASEDIR=$(pwd)
for entry in "$BASEDIR"/Gogh/themes/*
do
  if [ ! $entry == "$BASEDIR/Gogh/themes/README.md" ]; then
    array+=("$entry")
  fi
done

# =============================================================== #
# Read each file
# =============================================================== #
for element in "${array[@]}"
do
  new_theme_file="${element/.sh/.json}"
  theme_file_to_be_removed="$1/$(basename $new_theme_file)"
  if [ -f "$theme_file_to_be_removed" ]
  then
    rm $theme_file_to_be_removed
    wait
  fi
done

# =============================================================== #
# hopefully everything went smooth 
# =============================================================== #
printf "Successfully removed themes from : $1"

