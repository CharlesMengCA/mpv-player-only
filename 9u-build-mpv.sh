#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $SCRIPT_DIR/functions.sh

echo 'Start: ' $(date '+%H:%M:%S') > $HOME/build_time.txt

./1-download-mpv-winbuild-cmake.sh $1

[[ $1 == "1" || $2 == "1" ]] && exit

./2-disable-ffmpeg-encoder.sh

[[ $1 == "2" || $2 == "2" ]] && exit

if ! [[ $1 == "jxl" || $2 == "jxl" ]]; then
   ./disable-ffmpeg-jxl.sh
fi

if ! [[ $1 == "js" || $2 == "js" ]]; then
   ./toggleJS.sh "off"
fi

./3-disable-vapoursynth.sh
./4-use-old-version.sh
./5-disable-OpenGL.sh
./6-disable-libbs2b.sh
./7-new-toolchain.sh


cd $HOME/mpv-winbuild-cmake/build64

rm -rf mpv-*

ninja luajit-fullclean
ninja fontconfig-fullclean
ninja spirv-cross-fullclean
ninja vulkan-fullclean
ninja libdovi-fullclean
ninja rav1e-fullclean

ninja mpv

mpv_exe=$(find ~/mpv-winbuild-cmake/build64 -name mpv.exe)


echo 'Done: ' $(date '+%H:%M:%S') >> $HOME/build_time.txt
