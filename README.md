# Exiftool Scripts for Google Photos from Google Takeout
## TL;DR
To fix the metadata and clobber the originals:
```
exiftool -@ use_json.args <takeout_dir>
exiftool -@ jpg_to_mp4.args <takeout_dir>
exiftool -@ jpg_to_png.args <takeout_dir>
exiftool -@ png_to_jpg.args <takeout_dir>
exiftool -@ was_jpg_now_mp4.args <takeout_dir>
exiftool -@ was_jpg_now_png.args <takeout_dir>
exiftool -@ was_png_now_jpg.args <takeout_dir>
```

And if you like gambling:
```
exiftool -@ looks_like_a_date.args <takeout_dir>
exiftool -@ date_from_folder.args <takeout_dir>
```

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

## Scripts
The scripts should be run in the following order

### use_json.args
If the date-related metadata tags don't exist and the JSON file exists, merge
the tags.

### jpg_to_mp4.args
Rename .jpg files that are actually MP4 files to have the .mp4 extension

### jpg_to_png.args
Rename .jpg files that are actually PNG files to have the .png extension

### png_to_jpg.args
Rename .png files that are actually JPEG files to have the .jpg extension

### was_jpg_now_mp4.args
### was_jpg_now_png.args
### was_png_now_jpg.args
For those files renamed above, if the date-related metadata tags don't exist and
the JSON file exists, merge the tags.

## Scripts that take a leap of faith
Out of the thousands of photos, only a handful actually have a JSON file. This
is very disappointing and very unsatisfactory. In an attempt to fill in more
metadata, use some scripts that take a leap of faith.

### looks_like_a_date.args
Some filenames look to have the date and time encoded in the filename. Use that
to fill in the metadata tags.

There is only one sanity check in this script to make sure legitimate looking
dates are used. And that is to check that the year looks reasonable. For
instance, "VID_32100102_123456.mp4" will be rejected but
"IMG_20200901_123456.jpg" will not.

This is error-prone and I did have to manually adjust some files after running
this script.

### date_from_folder.args
Even after the first leap of faith scripts, there are still loads of files that
don't have any metadata. But Google Takeout arranges all files from the time
they were created and so use that fact to add metadata.

There are some big gotchas here.

* Only supports YYYY-MM-DD and no times
* Timezone might be off and so dates might be off by a day
* Doesn't understand when the photo was taken only when Google Photos was made
aware of it

I felt this was better than nothing and so in my local media server, I have
decided to keep the output of this scripts rather than have loads of pictures
grouped together because most tools just use the file system time in lieu of any
other times. And the file system time was when the files were extracted.

## Common themes in the scripts
PhotoTakenTimeTimestamp is the field extracted from the JSON

-AllDates<PhotoTakenTimeTimestamp is used for JPEGs

-XMP-Exif:DateTimeOriginal<PhotoTakenTimeTimestamp and
-PNG:CreationTime<PhotoTakenTimeTimestamp are used for PNGs. The former allows
Lightroom to understand the tags and the latter allows Windows Photo Viewer
to understand the tags.

-QuickTime:TrackCreateDate<PhotoTakenTimeTimestamp,
-QuickTime:TrackModifyDate<PhotoTakenTimeTimestamp,
-QuickTime:MediaCreateDate<PhotoTakenTimeTimestamp,
-QuickTime:MediaModifyDate<PhotoTakenTimeTimestamp are used for mp4 files. I'm
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
