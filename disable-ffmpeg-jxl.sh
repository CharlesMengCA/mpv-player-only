#!/bin/bash
source $(pwd)/functions.sh

[[ $1 == "" ]] && clear

echo $0 $@

cd ~/mpv-winbuild-cmake/

# following 3 lines need to be flipped together
comment_line ffmpeg "libjxl"
comment_line ffmpeg "--enable-libjxl"
comment_line ffmpeg "--enable-encoder=libjxl"

echo "libjxl: disabled" >> $HOME/build_time.txt