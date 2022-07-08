#!/bin/bash
source $(pwd)/functions.sh

StartTime=$(date '+%H:%M:%S')

clear && echo $0 $@

cd ~/mpv-winbuild-cmake/build64/

rm -r mpv-*
rm -r packages/mpv-prefix/src/mpv-build/generated/version.h



ninja mpv-fullclean
ninja mpv

echo 'Build:' $StartTime '->' $(date '+%H:%M:%S')