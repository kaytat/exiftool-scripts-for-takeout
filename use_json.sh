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

JSON_EXTENSION=supplemental-metadata.

while [[ -n $JSON_EXTENSION ]]; do
  JSON_EXTENSION=${JSON_EXTENSION::-1}
  echo "$EXIFTOOL" -tagsfromfile %d%F.${JSON_EXTENSION}.json -@ $(dirname "$0")/use_json_base.args -UserParam JSON_NAME=${JSON_EXTENSION}.json "$PHOTOS_DIR"
  "$EXIFTOOL" -tagsfromfile %d%F.${JSON_EXTENSION}.json -@ $(dirname "$0")/use_json_base.args -UserParam JSON_NAME=${JSON_EXTENSION}.json "$PHOTOS_DIR"
done

# One final case
echo "$EXIFTOOL" -tagsfromfile %d%F.json -@ $(dirname "$0")/use_json_base.args -UserParam JSON_NAME=json "$PHOTOS_DIR"
"$EXIFTOOL" -tagsfromfile %d%F.json -@ $(dirname "$0")/use_json_base.args -UserParam JSON_NAME=json "$PHOTOS_DIR"
