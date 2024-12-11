#!/bin/bash
source $(pwd)/functions.sh

StartTime=$(date '+%H:%M:%S')
clear && echo_info $0 $@

cd ~/mpv-winbuild-cmake/
rm -r mpv-lua
rm -r mpv-lua-mod

cd build64
rm -r mpv-*
#rm -r packages/mpv-prefix/src/mpv-build/common/version.h

ninja mpv-fullclean
ninja mpv

cd mpv-x86_64* && ls -g -o --time-style=iso *.exe
cd ../mpv-dev-x86_64-* && ls -g -o --time-style=iso *.dll

echo 'Build:' $StartTime '->' $(date '+%H:%M:%S')