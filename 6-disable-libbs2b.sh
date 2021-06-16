#!/bin/bash
clear
echo $0 $@

comment_line () {
	sed -i "/^\s*$2/s/^/#/g" packages/$1
}

cd ~/mpv-winbuild-cmake/

set -x #echo on

comment_line CMakeLists.txt libbs2b
comment_line ffmpeg.cmake libbs2b
comment_line ffmpeg.cmake --enable-libbs2b

# Mod format support
comment_line CMakeLists.txt libopenmpt
comment_line ffmpeg.cmake libopenmpt
comment_line ffmpeg.cmake --enable-libopenmpt

comment_line CMakeLists.txt libmodplug
comment_line ffmpeg.cmake libmodplug
comment_line ffmpeg.cmake --enable-libmodplug

# OpenAL
comment_line CMakeLists.txt openal-soft
comment_line mpv.cmake openal-soft
comment_line mpv.cmake --enable-openal
comment_line mpv-stable.cmake openal-soft
comment_line mpv-stable.cmake --enable-openal
