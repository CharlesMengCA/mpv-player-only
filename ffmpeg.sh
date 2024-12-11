#!/bin/bash
source $(pwd)/functions.sh

echo_info $0 $@

cd ~/mpv-winbuild-cmake/

#replace_option freetype2 "GIT_SHALLOW 1" "GIT_TAG VER-2-12-1"


add_option ffmpeg "GIT_SHALLOW 1" "GIT_TAG release/7.1"
append_option ffmpeg -pkg-config-flags=--static --disable-debug
append_option ffmpeg -pkg-config-flags=--static --disable-static
append_option ffmpeg -pkg-config-flags=--static --enable-shared

comment_line ffmpeg --disable-ffplay
comment_line ffmpeg --disable-ffprobe

# OpenAL
comment_line CMakeLists.txt "openal-soft"
comment_line ffmpeg "openal-soft"
comment_line ffmpeg "--enable-openal"
comment_line mpv openal-soft
comment_line mpv "-Dopenal=enabled"
comment_line mpv-release openal-soft
comment_line mpv-release "-Dopenal=enabled"

cd build64

ninja ffmpeg

mkdir ffmpeg

find packages/ffmpeg-prefix/src/ffmpeg-build/ -name *.exe -type f -exec cp {} ffmpeg \;
find packages/ffmpeg-prefix/src/ffmpeg-build/ -name *.dll -type f -exec cp {} ffmpeg \;

cd ffmpeg
#rm *_g.exe

strip -s *.*