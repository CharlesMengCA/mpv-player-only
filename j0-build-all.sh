#!/bin/bash
StartTime=$(date '+%H:%M:%S')
./1-download-mpv-winbuild-cmake.sh
./2-disable-ffmpeg-encoder.sh
./3-disable-vapoursynth.sh
./4-use-old-version.sh
./5-disable-OpenGL.sh
./6-disable-libbs2b.sh
./7-new-toolchain.sh

if [[ $1 == "clang" ]]; then
   ./8c-clang.sh
else
   ./8g-gcc.sh
fi

[[ $1 == "8" ]] && exit
[[ $2 == "8" ]] && exit

./9b-build-mpv.sh

mpv_exe=$(find ~/mpv-winbuild-cmake/build64 -name mpv.exe)

[[ $mpv_exe == "" ]] && ./jm.sh

echo 'Build:' $StartTime '->' $(date '+%H:%M:%S')
