echo off

REM
REM Find media files with missing time info that have an associated metadata
REM file. This is considered a dry-run since the media file will not be
REM modified.
REM
REM Usage:
REM   dry_run.bat exiftool_location photos_directory
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
        echo %1 -@ %~dp0dry_run_base.args -UserParam JSON_NAME=%%j %2
        %1 -@ %~dp0dry_run_base.args -UserParam JSON_NAME=%%j %2
    )
