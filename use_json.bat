echo off

REM
REM Fill in from Google's JSON.
REM
REM The parameter -tagsfromfile is passed into use_json_base.args since the
REM -tagsfromfile option cannot handled variable names. %d%F.$JSON_NAME results
REM with exiftool trying to read the file some_dir/some_file.$JSON_NAME with
REM that literal extension name. To work around this, it seems like passing in
REM the string works.
REM
REM Note that the name of the metadata extension changes with the overall-length
REM of the filename. And so attempt to find all the variants of the extension
REM name.
REM
REM Usage:
REM   use_json.bat exiftool_location photos_directory
REM

set EXIFTOOL=%1
set PHOTOS_DIR=%2

for %%j in (
    supplemental-metadata.json
    supplemental-metadat.json
    supplemental-metada.json
    supplemental-metad.json
    supplemental-meta.json
    supplemental-met.json
    supplemental-me.json
    supplemental-m.json
    supplemental-.json
    supplemental.json
    supplementa.json
    supplement.json
    supplemen.json
    suppleme.json
    supplem.json
    supple.json
    suppl.json
    supp.json
    sup.json
    su.json
    s.json
    json
    ) do (
        echo %1 -tagsfromfile %%d%%F.%%j -@ %~dp0use_json_base.args -UserParam JSON_NAME=%%j %2
        %1 -tagsfromfile %%d%%F.%%j -@ %~dp0use_json_base.args -UserParam JSON_NAME=%%j %2
    )
