#!/bin/bash
source $(pwd)/functions.sh

clear && echo $0 $@

cd ~/mpv-winbuild-cmake/

# libbs2b
comment_line CMakeLists.txt libbs2b
comment_line ffmpeg libbs2b
comment_line ffmpeg --enable-libbs2b

# Mod format support
comment_line CMakeLists.txt libopenmpt
comment_line ffmpeg libopenmpt
comment_line ffmpeg --enable-libopenmpt

comment_line CMakeLists.txt libmodplug
comment_line ffmpeg libmodplug
comment_line ffmpeg --enable-libmodplug

# The Speex codec has been obsoleted by Opus
comment_line CMakeLists.txt speex
comment_line ffmpeg speex
comment_line ffmpeg --enable-libspeex

# OpenAL
comment_line CMakeLists.txt openal-soft
comment_line mpv openal-soft
comment_line mpv --enable-openal
comment_line mpv-release openal-soft
comment_line mpv-release --enable-openal

#opus-tools
comment_line CMakeLists.txt opus-tools
comment_line CMakeLists.txt libopusenc
comment_line CMakeLists.txt opusfile

# rubberband - Better scaletempo (on high speed x1.5-x3)
comment_line CMakeLists.txt rubberband
comment_line mpv rubberband
comment_line mpv --enable-rubberband
comment_line mpv-release rubberband
comment_line mpv-release --enable-rubberband

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
