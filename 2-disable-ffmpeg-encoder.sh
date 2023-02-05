#!/bin/bash
source $(pwd)/functions.sh

clear && echo $0 $@

cd ~/mpv-winbuild-cmake/

# FFmpeg version: git-2023-01-22-9d5e66942
add_option ffmpeg "GIT_CLONE_FLAGS " "GIT_SHALLOW 1"
comment_line ffmpeg "GIT_CLONE_FLAGS "

append_option ffmpeg -pkg-config-flags=--static --disable-programs
#append_option ffmpeg -pkg-config-flags=--static --disable-doc
append_option ffmpeg -pkg-config-flags=--static --disable-debug

# following 3 lines need to be flipped together
#comment_line ffmpeg "--enable-libjxl"
append_option ffmpeg -pkg-config-flags=--static --enable-encoder=libjxl

#build mpv.exe and skip mpv-2.dll
#comment_line mpv "-Dlibmpv=true"

#append_option ffmpeg -pkg-config-flags=--static --enable-encoder=libwebp
append_option ffmpeg -pkg-config-flags=--static --disable-encoders
#add_option ffmpeg -pkg-config-flags=--static --enable-shared

#https://ffmpeg.org/ffmpeg-formats.html#Muxers
append_option ffmpeg -pkg-config-flags=--static --disable-muxers
#https://ffmpeg.org/ffmpeg-filters.html#Description
append_option ffmpeg -pkg-config-flags=--static --disable-filters
