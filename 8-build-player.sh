#!/bin/bash
clear && echo $0 $@

cd ~/mpv-winbuild-cmake/

StartTime=$(date '+%H:%M:%S')
set -x #echo on

mkdir build64
cd build64

cmake -DTARGET_ARCH=x86_64-w64-mingw32 -G Ninja ..

ninja gcc

{ set +x; } 2>/dev/null # echo off
echo 'Build:' $StartTime '->' $(date '+%H:%M:%S')