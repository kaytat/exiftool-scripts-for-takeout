#!/bin/bash

EXIFTOOL=$1
PHOTOS_DIR=$2

if [[ -z "$EXIFTOOL" || ! -e "$EXIFTOOL" ]]; then
  echo exiftool binary must be specified.
  echo Usage:
  echo   $0 exiftool_location photos_directory
  exit
fi

if [[ -z "$PHOTOS_DIR" || ! -e "$PHOTOS_DIR" ]]; then
  echo photos directory must be specified.
  echo Usage:
  echo   $0 exiftool_location photos_directory
  exit
fi

echo "$EXIFTOOL" -@ $(dirname "$0")/find_missing_base.args "$PHOTOS_DIR"
"$EXIFTOOL" -@ $(dirname "$0")/find_missing_base.args "$PHOTOS_DIR"
