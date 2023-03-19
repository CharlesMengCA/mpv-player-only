#!/bin/bash
StartTime=$(date '+%H:%M:%S')
./1-download-mpv-winbuild-cmake.sh
./2-disable-ffmpeg-encoder.sh
./3-disable-vapoursynth.sh
./4-use-old-version.sh
./5-disable-OpenGL.sh
./6-disable-libbs2b.sh
./7-new-toolchain.sh
./8-build-player.sh
./9b-build-mpv.sh

mpv_exe=$(find ~/mpv-winbuild-cmake/build64 -name mpv.exe)

if [[ $mpv_exe == "" ]]; then
   ./jm.sh
fi

echo 'Build:' $StartTime '->' $(date '+%H:%M:%S')
