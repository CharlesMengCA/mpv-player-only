#!/bin/bash
./updateSystem.sh
echo 'Start: ' $(date '+%H:%M:%S') > $HOME/build_time.txt

./1-download-mpv-winbuild-cmake.sh $1

[[ $1 == "1" || $2 == "1" ]] && exit

./2-disable-ffmpeg-encoder.sh "all"

[[ $1 == "2" || $2 == "2" ]] && exit

if ! [[ $1 == "jxl" || $2 == "jxl" ]]; then
   ./disable-ffmpeg-jxl.sh "all"
fi

if ! [[ $1 == "js" || $2 == "js" ]]; then
   ./toggleJS.sh "off"
fi

./3-disable-vapoursynth.sh "all"
./4-use-old-version.sh $1 "all"

[[ $1 == "4" || $2 == "4" ]] && exit

./5-disable-OpenGL.sh  "all"
./6-disable-libbs2b.sh "all"
./7-new-toolchain.sh "all"

[[ $1 == "7" || $2 == "7" ]] && exit

if [[ $1 == "gcc" ]]; then
   ./8g-gcc.sh
else
   ./8c-clang.sh $1
fi

[[ $1 == "8" || $2 == "8" ]] && exit

./9b-build-mpv.sh

mpv_exe=$(find ~/mpv-winbuild-cmake/build64 -name mpv.exe)

[[ $1 == "" && $mpv_exe == "" ]] && ./clang.sh

echo 'Done: ' $(date '+%H:%M:%S') >> $HOME/build_time.txt
