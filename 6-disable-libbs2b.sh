#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $SCRIPT_DIR/functions.sh

[[ $1 == "" ]] && clear
echo_info $0 $@

cd ~/mpv-winbuild-cmake/

# libbs2b
comment_line CMakeLists.txt libbs2b
comment_line ffmpeg libbs2b
comment_line ffmpeg --enable-libbs2b

# The Speex codec has been obsoleted by Opus
comment_line CMakeLists.txt speex
comment_line ffmpeg speex
comment_line ffmpeg --enable-libspeex

# davs2
comment_line CMakeLists.txt davs2
comment_line ffmpeg "\${ffmpeg_davs2}"
comment_line ffmpeg "\${ffmpeg_davs2_cmd}"

# uavs3d
comment_line CMakeLists.txt uavs3d
comment_line ffmpeg "\${ffmpeg_uavs3d}"
comment_line ffmpeg "\${ffmpeg_uavs3d_cmd}"

# libzvbi - teletext based subtitles
comment_line CMakeLists.txt libzvbi
comment_line ffmpeg libzvbi
comment_line ffmpeg --enable-libzvbi

#aribb24 - a library used for decoding closed captioning from ISDB streams, commonly used on Japanese TV
#comment_line CMakeLists.txt aribb24
#comment_line ffmpeg aribb24
#comment_line ffmpeg --enable-libaribb24

comment_line CMakeLists.txt libaribcaption
comment_line ffmpeg libaribcaption
comment_line ffmpeg --enable-libaribcaption

# libva
comment_line CMakeLists.txt libva
comment_line ffmpeg libva
#comment_line mesa libva
replace_option ffmpeg "--enable-vaapi" "--disable-vaapi"

#opus-tools
comment_line CMakeLists.txt opus-tools
comment_line CMakeLists.txt libopusenc
comment_line CMakeLists.txt opusfile

# rubberband - Better scaletempo (on high speed x1.5-x3)
comment_line CMakeLists.txt rubberband
comment_line ffmpeg rubberband
comment_line ffmpeg "--enable-librubberband"
comment_line mpv rubberband
replace_option mpv "-Drubberband=enabled" "-Drubberband=disabled"
comment_line mpv-release rubberband
replace_option mpv-release "-Drubberband=enabled" "-Drubberband=disabled"

#game-music-emu
comment_line CMakeLists.txt game-music-emu

#megasdk
comment_line CMakeLists.txt termcap
comment_line CMakeLists.txt readline
comment_line CMakeLists.txt cryptopp
comment_line CMakeLists.txt sqlite
comment_line CMakeLists.txt libuv
comment_line CMakeLists.txt libsodium
comment_line CMakeLists.txt megasdk
