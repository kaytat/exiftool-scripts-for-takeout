# Exiftool Scripts for Google Photos from Google Takeout
## TL;DR (Update 9/1/2025)
Find files that are missing time info:
```
find_missing.bat path_to_exiftool path_to_photos
```

Get a list of media that has metadata that might have time info:
```
dry_run.bat path_to_exiftool path_to_photos
```

Update media with time info from metadata:
```
use_json.bat path_to_exiftool path_to_photos
```

## Recent Changes (Update 9/1/2025)

### Metadata filename extension changes
When this project was first created, the metadata was in a file that appended
".json" to the end of the media file. This has changed and now the extension
is ".supplemental-metadata.json"

But some of the time, the filenames seem to get truncated and so the extension
becomes ".supplemental-metada.json". Notice the missing "ta" at the end of data.

This can be as short as ".s.json".

The batch files are built to try and account for these variations.

### Directory flattening

Previously the media files were split by YYYY-MM-DD. Now, it seems like it's 
much flatter and I only see "Photos from YYYY".

### metadata.json missing for non-album directories

Previously, there was a metadata.json file for each dated directory. But they
don't seem to exist anymore

## Background
The photos I have taken over the years are scattered across a large number of
storage media - phones, laptops, cloud services, memory cards, external drives,
NAS, etc.

I've been slowly trying to consolidate them into a central location so that I
can view all of them at once. And the chosen destination is a local media
server.

Part of this effort is to get all of my photos off of Google Photos and copied
locally. Google provides access to this quite easily using
[Google Takeout](https://support.google.com/accounts/answer/3024190?hl=en), but
unfortunately, the photos are a bit of a mess.

Specifically, the photos themselves generally lack metadata that would allow
other external programs to accurately index them. But the takeout artifacts
usually have a corresponding JSON file that does have that metadata.

## Goal
The goal is to use [Exiftool](http://exiftool.org/) to merge the metadata found
in the JSON files into the EXIF/PNG/QuickTime/etc tags in the photos/videos
themselves.

This way a tool like Lightroom can read the photos in and have all the
metadata available.

## Common themes in the scripts
PhotoTakenTimeTimestamp is the field extracted from the JSON

-AllDates\<PhotoTakenTimeTimestamp is used for JPEGs

-XMP-Exif:DateTimeOriginal\<PhotoTakenTimeTimestamp and
-PNG:CreationTime\<PhotoTakenTimeTimestamp are used for PNGs. The former allows
Lightroom to understand the tags and the latter allows Windows Photo Viewer
to understand the tags.

-QuickTime:TrackCreateDate\<PhotoTakenTimeTimestamp,
-QuickTime:TrackModifyDate\<PhotoTakenTimeTimestamp,
-QuickTime:MediaCreateDate\<PhotoTakenTimeTimestamp,
-QuickTime:MediaModifyDate\<PhotoTakenTimeTimestamp are used for mp4 files. I'm
not sure which one is right so just went for a blanket approach.

ConvertUnixTime() is used to convert the UTC timestamp in the JSON to a local
time.

## Caveats
-overwrite_original is used because I still have all the zips from Takeout.

Timezones and UTC is still a mystery and I can't get it right. Sometimes
the files/JSON are just bad.

This was all done on a Windows 10 laptop. I don't know if everything in the
scripts are supported on all Windows/Mac/Linux.

## Tweaks
Don't want the scripts to clobber the originals? Remove -overwrite_original

Are there photos or albums you thought you deleted but still remain? Try
the [album archive](https://get.google.com/albumarchive) and especially the
"Auto Backup" album. Not sure what this is, but there were a lot old / unwanted
photos in there.

## Improvements
The JSON files have album info. Maybe that can be merged too?

# Obsolete scripts for kept for reference
```
burst.args
date_from_folder.args
jpg_to_mp4.args
jpg_to_png.args
looks_like_a_date.args
png_to_jpg.args
use_json.args
was_jpg_now_mp4.args
was_jpg_now_png.args
was_png_now_jpg.args
```

For details on what these used to do, view the history of README.md. Most of
these were helper scripts when EXIFTOOL complains about the filename vs the
content.

These also assume the older naming convention of the metadata files.
