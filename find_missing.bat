echo off

REM
REM Find media files with missing time info
REM
REM Usage:
REM   find_missing.bat exiftool_location photos_directory
REM

set EXIFTOOL=%1
set PHOTOS_DIR=%2

echo %1 -@ %~dp0find_missing_base.args %2
%1 -@ %~dp0find_missing_base.args %2
