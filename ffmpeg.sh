#!/bin/bash
source $(pwd)/functions.sh

clear && echo $0 $@

cd ~/mpv-winbuild-cmake/
set -x #echo on

#add_option ffmpeg "GIT_SHALLOW 1" "GIT_TAG n4.4.1"
add_option ffmpeg -pkg-config-flags=--static --disable-debug
add_option ffmpeg -pkg-config-flags=--static --enable-shared

comment_line packages/CMakeLists.txt libbs2b
comment_line ffmpeg.cmake libbs2b
comment_line ffmpeg.cmake --enable-libbs2b

# Mod format support
comment_line packages/CMakeLists.txt libopenmpt
comment_line ffmpeg.cmake libopenmpt
comment_line ffmpeg.cmake --enable-libopenmpt

comment_line packages/CMakeLists.txt libmodplug
comment_line ffmpeg.cmake libmodplug
comment_line ffmpeg.cmake --enable-libmodplug

# The Speex codec has been obsoleted by Opus
comment_line packages/CMakeLists.txt speex
comment_line ffmpeg.cmake speex
comment_line ffmpeg.cmake --enable-libspeex

mkdir build64
cd build64

cmake -DTARGET_ARCH=x86_64-w64-mingw32 -G Ninja ..

ninja gcc

ninja ffmpeg

mkdir ./ffmpeg

find ffmpeg-prefix/src/ffmpeg-build/ -name *.exe -type f -exec cp {} ./ffmpeg \;
find ffmpeg-prefix/src/ffmpeg-build/ -name *.dll -type f -exec cp {} ./ffmpeg \;

cd ./ffmpeg
rm *_g.exe

strip -s *.*
