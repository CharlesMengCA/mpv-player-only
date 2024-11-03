#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $SCRIPT_DIR/functions.sh

[[ $1 == "" ]] && clear

echo_info $0 $@

cd ~/mpv-winbuild-cmake/

# FFmpeg version: git-2023-01-22-9d5e66942
add_option ffmpeg "GIT_CLONE_FLAGS " "GIT_SHALLOW 1"
comment_line ffmpeg "GIT_CLONE_FLAGS "

append_option ffmpeg -pkg-config-flags=--static --disable-programs
append_option ffmpeg -pkg-config-flags=--static --disable-debug

append_option ffmpeg -pkg-config-flags=--static --enable-encoder=libjxl
#append_option ffmpeg -pkg-config-flags=--static --enable-encoder=libwebp
append_option ffmpeg -pkg-config-flags=--static --disable-encoders
#add_option ffmpeg -pkg-config-flags=--static --enable-shared

#https://ffmpeg.org/ffmpeg-formats.html#Muxers
append_option ffmpeg -pkg-config-flags=--static --disable-muxers

#https://ffmpeg.org/ffmpeg-filters.html#Description
append_option ffmpeg -pkg-config-flags=--static --enable-filter=yadif
append_option ffmpeg -pkg-config-flags=--static --enable-filter=yadif_cuda
append_option ffmpeg -pkg-config-flags=--static --enable-filter=bwdif
append_option ffmpeg -pkg-config-flags=--static --enable-filter=bwdif_cuda
append_option ffmpeg -pkg-config-flags=--static --enable-filter=framesync
append_option ffmpeg -pkg-config-flags=--static --enable-filter=scale
append_option ffmpeg -pkg-config-flags=--static --enable-filter=scale_cuda
append_option ffmpeg -pkg-config-flags=--static --enable-filter=scale_npp
append_option ffmpeg -pkg-config-flags=--static --enable-filter=scale2ref
append_option ffmpeg -pkg-config-flags=--static --enable-filter=scale2ref_npp
append_option ffmpeg -pkg-config-flags=--static --disable-filters
append_option ffmpeg -pkg-config-flags=--static --disable-ptx-compression
append_option ffmpeg -pkg-config-flags=--static "--nvccflags='-O3'"

#ffmpeg: re-enable hardcoded tables
#The culprit that broke hardcoded tables build was aac_fixed, and since current x86 baseline requires SSE2, we don't need slow fixed-point decoder, disable it will fix hardcoded tables build
append_option ffmpeg "--enable-runtime-cpudetect" "--enable-hardcoded-tables"
replace_option ffmpeg "--disable-decoder=libaom_av1" "--disable-decoder=libaom_av1,aac_fixed,ac3_fixed"
