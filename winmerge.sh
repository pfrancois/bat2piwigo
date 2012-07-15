#!/bin/sh
echo Launching WinMergeU.exe: $1 $2
"C:/Program Files/WinMerge/WinMergeU.exe" -e -ub -dl "Base" -dr "Mine" "$1" "$2"
