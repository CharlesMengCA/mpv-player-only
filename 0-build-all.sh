#!/bin/bash
./updateSystem.sh
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
