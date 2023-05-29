#!/bin/bash
StartTime=$(date '+%H:%M:%S')
./1-download-mpv-winbuild-cmake.sh
./2-disable-ffmpeg-encoder.sh
./disable-ffmpeg-jxl.sh
./3-disable-vapoursynth.sh
./4-use-old-version.sh
./5-disable-OpenGL.sh
./6-disable-libbs2b.sh
./7-new-toolchain.sh
./8-build-player.sh
[[ $1 == "8" ]] && exit
./9b-build-mpv.sh


echo 'Build:' $StartTime '->' $(date '+%H:%M:%S')