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
# Get colors into a temp script
# =============================================================== #
trim_script() {
  linenumber="$(sed -n '/PROFILE_NAME/=' $1)"
  trimmed_file="${1/.sh/_trimmed.sh}"
  sed "$(($linenumber + 1))""q" "$1" > $trimmed_file
  wait
  echo $trimmed_file
}

# =============================================================== #
# Read each file
# =============================================================== #
for element in "${array[@]}"
do
  trimmed=$(trim_script "$element")
  . $trimmed
  new_theme_file="${element/.sh/.json}"
  if [ -f "$new_theme_file" ]
  then
    rm "$new_theme_file"
    wait
  fi
  touch "$new_theme_file"
  echo -e "{\n    \"background-color\": \"$BACKGROUND_COLOR\"," >> $new_theme_file
  echo -e "    \"badge-color\": \"$BACKGROUND_COLOR\"," >> $new_theme_file
  echo -e "    \"bold-color\": \"$BACKGROUND_COLOR\"," >> $new_theme_file
  echo -e "    \"comment\": \"Generated with gogh-to-tilix.\"," >> $new_theme_file
  echo -e "    \"cursor-background-color\": \"$BACKGROUND_COLOR\"," >> $new_theme_file
  echo -e "    \"cursor-foreground-color\": \"$CURSOR_COLOR\"," >> $new_theme_file
  echo -e "    \"foreground-color\": \"$FOREGROUND_COLOR\"," >> $new_theme_file
  echo -e "    \"highlight-background-color\": \"$FOREGROUND_COLOR\"," >> $new_theme_file
  echo -e "    \"highlight-foreground-color\": \"$BACKGROUND_COLOR\"," >> $new_theme_file
  echo -e "    \"name\": \"$PROFILE_NAME\"," >> $new_theme_file
  echo -e "    \"palette\": [" >> $new_theme_file
  echo -e "        \"$COLOR_01\"," >> $new_theme_file
  echo -e "        \"$COLOR_02\"," >> $new_theme_file
  echo -e "        \"$COLOR_03\"," >> $new_theme_file
  echo -e "        \"$COLOR_04\"," >> $new_theme_file
  echo -e "        \"$COLOR_05\"," >> $new_theme_file
  echo -e "        \"$COLOR_06\"," >> $new_theme_file
  echo -e "        \"$COLOR_07\"," >> $new_theme_file
  echo -e "        \"$COLOR_08\"," >> $new_theme_file
  echo -e "        \"$COLOR_09\"," >> $new_theme_file
  echo -e "        \"$COLOR_10\"," >> $new_theme_file
  echo -e "        \"$COLOR_11\"," >> $new_theme_file
  echo -e "        \"$COLOR_12\"," >> $new_theme_file
  echo -e "        \"$COLOR_13\"," >> $new_theme_file
  echo -e "        \"$COLOR_14\"," >> $new_theme_file
  echo -e "        \"$COLOR_15\"," >> $new_theme_file
  echo -e "        \"$COLOR_16\"" >> $new_theme_file
  echo -e "    ]," >> $new_theme_file
  echo -e "    \"use-badge-color\": true," >> $new_theme_file
  echo -e "    \"use-bold-color\": false," >> $new_theme_file
  echo -e "    \"use-cursor-color\": false," >> $new_theme_file
  echo -e "    \"use-highlight-color\": false," >> $new_theme_file
  echo -e "    \"use-theme-colors\": false" >> $new_theme_file
  echo -e "}" >> $new_theme_file
  wait
  mv $new_theme_file "$1/$(basename $new_theme_file)"
  wait
  rm $trimmed
done

printf "Successfully added ${#array[@]} theme files into : $1"

