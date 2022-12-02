#!/bin/bash
source $(pwd)/functions.sh

clear && echo $0 $@

cd ~/mpv-winbuild-cmake/

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

exit
append_option ffmpeg -pkg-config-flags=--static --disable-filter=colorspectrum
append_option ffmpeg -pkg-config-flags=--static --disable-filter=showspectrum
append_option ffmpeg -pkg-config-flags=--static --disable-filter=showspectrumpic
append_option ffmpeg -pkg-config-flags=--static --disable-filter=spectrumsynth

append_option ffmpeg -pkg-config-flags=--static --disable-filter=allrgb
append_option ffmpeg -pkg-config-flags=--static --disable-filter=allyuv
append_option ffmpeg -pkg-config-flags=--static --disable-filter=color
append_option ffmpeg -pkg-config-flags=--static --disable-filter=colorchart
append_option ffmpeg -pkg-config-flags=--static --disable-filter=haldclutsrc
append_option ffmpeg -pkg-config-flags=--static --disable-filter=nullsrc
append_option ffmpeg -pkg-config-flags=--static --disable-filter=pal75bars
append_option ffmpeg -pkg-config-flags=--static --disable-filter=pal100bars
append_option ffmpeg -pkg-config-flags=--static --disable-filter=rgbtestsrc
append_option ffmpeg -pkg-config-flags=--static --disable-filter=smptebars
append_option ffmpeg -pkg-config-flags=--static --disable-filter=smptehdbars
append_option ffmpeg -pkg-config-flags=--static --disable-filter=testsrc
append_option ffmpeg -pkg-config-flags=--static --disable-filter=testsrc2
append_option ffmpeg -pkg-config-flags=--static --disable-filter=yuvtestsrc



