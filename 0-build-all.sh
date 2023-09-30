#!/bin/bash
echo 'Start: ' $(date '+%H:%M:%S') > $HOME/build_time.txt
./1-download-mpv-winbuild-cmake.sh $1
./2-disable-ffmpeg-encoder.sh
./disable-ffmpeg-jxl.sh
./3-disable-vapoursynth.sh
./4-use-old-version.sh
./5-disable-OpenGL.sh
./6-disable-libbs2b.sh
./7-new-toolchain.sh

echo 'Before toolchain: ' $(date '+%H:%M:%S') >> $HOME/build_time.txt

if [[ $1 == "gcc" ]]; then
   ./8g-gcc.sh
else
   ./8c-clang.sh
fi

echo 'After toolchain: ' $(date '+%H:%M:%S') >> $HOME/build_time.txt

[[ $1 == "8" ]] && exit
[[ $2 == "8" ]] && exit

./9b-build-mpv.sh

mpv_exe=$(find ~/mpv-winbuild-cmake/build64 -name mpv.exe)

[[ $1 == "" && $mpv_exe == "" ]] && ./clang.sh

echo 'Build MPV: ' $(date '+%H:%M:%S') >> $HOME/build_time.txt
