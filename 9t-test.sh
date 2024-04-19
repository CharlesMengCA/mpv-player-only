#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $SCRIPT_DIR/functions.sh

$SCRIPT_DIR/1-download-mpv-winbuild-cmake.sh $1
$SCRIPT_DIR/2-disable-ffmpeg-encoder.sh
$SCRIPT_DIR/3-disable-vapoursynth.sh
$SCRIPT_DIR/4-use-old-version.sh
$SCRIPT_DIR/5-disable-OpenGL.sh
$SCRIPT_DIR/6-disable-libbs2b.sh

cd ~/mpv-winbuild-cmake

#cp -v --preserve=timestamps $SCRIPT_DIR/Patch/openssl-*.patch ./packages
#add_option openssl "UPDATE_COMMAND " "PATCH_COMMAND \$\{EXEC\} \$\{CMAKE_CURRENT_SOURCE_DIR\}\/cm-patch.sh"

#$SCRIPT_DIR/8c-clang.sh $1

cd build64

rm -rf mpv-*

ninja openssl-fullclean
ninja openssl

ninja luajit-fullclean
ninja fontconfig-fullclean
ninja spirv-cross-fullclean
ninja vulkan-fullclean

ninja mpv-fullclean
ninja mpv

cd mpv-x86_64* && ls -g -o --time-style=iso *.exe
cd ../mpv-dev-x86_64-* && ls -g -o --time-style=iso *.dll
