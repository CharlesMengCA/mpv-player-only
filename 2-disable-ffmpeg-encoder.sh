#!/bin/bash
source $(pwd)/functions.sh

clear && echo $0 $@

cd ~/mpv-winbuild-cmake/

append_option ffmpeg -pkg-config-flags=--static --disable-programs
append_option ffmpeg -pkg-config-flags=--static --disable-doc
append_option ffmpeg -pkg-config-flags=--static --disable-debug
append_option ffmpeg -pkg-config-flags=--static --disable-encoders
#add_option ffmpeg -pkg-config-flags=--static --enable-shared