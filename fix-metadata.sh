#!/usr/bin/env bash

test -z "$1" && echo "Usage: $0 <takeout_dir> [--unsafe]" && exit 1

TAKEOUT_DIR=$1

exiftool -@ use_json.args "$TAKEOUT_DIR"
exiftool -@ jpg_to_mp4.args "$TAKEOUT_DIR"
exiftool -@ jpg_to_png.args "$TAKEOUT_DIR"
exiftool -@ png_to_jpg.args "$TAKEOUT_DIR"
exiftool -@ heic_to_jpg.args "$TAKEOUT_DIR"
exiftool -@ was_jpg_now_mp4.args "$TAKEOUT_DIR"
exiftool -@ was_jpg_now_png.args "$TAKEOUT_DIR"
exiftool -@ was_png_now_jpg.args "$TAKEOUT_DIR"
exiftool -@ was_heic_now_jpg.args "$TAKEOUT_DIR"

if test "$2" != "--unsafe"; then exit 0; fi

exiftool -@ looks_like_a_date.args "$TAKEOUT_DIR"
exiftool -@ burst.args "$TAKEOUT_DIR"
exiftool -@ date_from_folder.args "$TAKEOUT_DIR"