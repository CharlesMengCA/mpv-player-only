#!/bin/bash
StartTime=$(date '+%H:%M:%S')

./1-download-mpv-winbuild-cmake.sh

pip3 install rst2pdf

./8-build-player.sh

set -x #echo on
cd ~/mpv-winbuild-cmake/build64/

ninja shaderc
ninja spirv-cross
ninja libarchive
ninja libass
#ninja harfbuzz
ninja libjxl
ninja libplacebo

ninja mpv

{ set +x; } 2>/dev/null # echo off

echo 'Build:' $StartTime '->' $(date '+%H:%M:%S')
