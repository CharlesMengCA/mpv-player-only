#!/bin/bash
source $(pwd)/functions.sh

clear && echo $0 $@

cd ~/mpv-winbuild-cmake/

append_option ffmpeg -pkg-config-flags=--static --disable-programs
#append_option ffmpeg -pkg-config-flags=--static --disable-doc
append_option ffmpeg -pkg-config-flags=--static --disable-debug

# following 3 lines need to be flipped together
comment_line ffmpeg "libjxl"
comment_line ffmpeg "--enable-libjxl"
#append_option ffmpeg -pkg-config-flags=--static --enable-encoder=libjxl

#build mpv.exe and skip mpv-2.dll
#comment_line mpv "-Dlibmpv=true"

#append_option ffmpeg -pkg-config-flags=--static --enable-encoder=libwebp
append_option ffmpeg -pkg-config-flags=--static --disable-encoders
#add_option ffmpeg -pkg-config-flags=--static --enable-shared