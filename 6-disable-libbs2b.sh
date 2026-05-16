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
git am --3way $SCRIPT_DIR/Patch/822_davs2_10bits.patch
#comment_line CMakeLists.txt davs2
#comment_line ffmpeg "\${ffmpeg_davs2}"
#comment_line ffmpeg "\${ffmpeg_davs2_cmd}"

# uavs3d
comment_line CMakeLists.txt uavs3d
comment_line ffmpeg "\${ffmpeg_uavs3d}"
comment_line ffmpeg "\${ffmpeg_uavs3d_cmd}"

# libzvbi - teletext based subtitles
comment_line CMakeLists.txt libzvbi
comment_line ffmpeg libzvbi
comment_line ffmpeg --enable-libzvbi

#aribb24 - a library used for decoding closed captioning from ISDB streams, commonly used on Japanese TV
comment_line CMakeLists.txt aribb24
comment_line ffmpeg aribb24
comment_line ffmpeg --enable-libaribb24

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


# LAME (Lame Ain’t an MP3 Encoder) MP3 encoder wrapper. 
comment_line CMakeLists.txt lame
comment_line ffmpeg lame
comment_line ffmpeg "--enable-libmp3lame"

#game-music-emu
comment_line CMakeLists.txt game-music-emu
comment_line ffmpeg game-music-emu
comment_line ffmpeg --enable-libgme

#xvidcore - FFmpeg (libavcodec) natively supports MPEG-4 ASP, which includes Xvid and DivX, without needing the xvidcore library installed
comment_line CMakeLists.txt xvidcore
comment_line ffmpeg xvidcore
comment_line ffmpeg --enable-libxvid

#megasdk
comment_line CMakeLists.txt termcap
comment_line CMakeLists.txt readline
comment_line CMakeLists.txt cryptopp
comment_line CMakeLists.txt sqlite
comment_line CMakeLists.txt libuv
comment_line CMakeLists.txt libsodium
comment_line CMakeLists.txt megasdk

#libsixel - Graphical output for the terminal, using sixels
comment_line CMakeLists.txt libsixel
comment_line mpv libsixel
comment_line mpv "-Dsixel=enabled"
comment_line mpv-release libsixel
comment_line mpv-release "-Dsixel=enabled"

#NVDEC is a marketing rebranding and improvement upon CUVID, now integrated into the NVIDIA Video Codec SDK and often requiring less VRAM and offering better performance
replace_option packages_check "--enable-cuda-llvm --enable-cuvid --enable-nvdec --enable-nvenc" "--enable-cuda-llvm --enable-nvdec"

#FFmpeg can decode H.264 video streams, which are often encoded using the x264 library. 
#While x264 is primarily an encoder, FFmpeg utilizes its own built-in H.264 decoder or can leverage other available decoders for H.264 content.
comment_line CMakeLists.txt x264
comment_line ffmpeg x264
comment_line ffmpeg --enable-libx264

#FFmpeg utilizes libx265 for encoding H.265/HEVC video streams, and it includes its own built-in decoder for H.265/HEVC content
comment_line CMakeLists.txt x265
comment_line ffmpeg \${ffmpeg_x265}
comment_line ffmpeg --enable-libx265

#A subtitle rendering library which aims to render SRV3 (YouTube) subtitles and WebVTT subtitles accurately
comment_line CMakeLists.txt subrandr
comment_line mpv subrandr
comment_line mpv "-Dsubrandr=enabled"
comment_line mpv-release subrandr
comment_line mpv-release "-Dsubrandr=enabled"
