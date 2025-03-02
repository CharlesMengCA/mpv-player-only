#!/bin/bash
rm -rf $HOME/mpv-winbuild-cmake/

./updateSystem.sh
echo 'Start: ' $(date '+%H:%M:%S') > $HOME/build_time.txt
sudo pacman -S --noconfirm --needed p7zip

echo -e '\nRestoring pre-built llvm...'
7z x -so Patch/llvm.tar.7z | tar xf - -C ~

./1-download-mpv-winbuild-cmake.sh $1

if [[ $1 == "ffmpeg" || $2 == "ffmpeg" ]]; then
   ./ffmpeg.sh
   exit
fi


./2-disable-ffmpeg-encoder.sh "all"

[[ $1 == "2" || $2 == "2" ]] && exit

if ! [[ $1 == "jxl" || $2 == "jxl" ]]; then
   ./disable-ffmpeg-jxl.sh "all"
fi

if [[ $1 == "js" || $2 == "js" ]]; then
   ./toggleJS.sh "on"
else
   ./toggleJS.sh "off"
fi

./3-disable-vapoursynth.sh "all"
./4-use-old-version.sh "all"
./5-disable-OpenGL.sh "all"
./6-disable-libbs2b.sh "all"
./7-new-toolchain.sh "all"

[[ $1 == "8" ]] && exit
[[ $2 == "8" ]] && exit

./9b-build-mpv.sh

mpv_exe=$(find ~/mpv-winbuild-cmake/build64 -name mpv.exe)

[[ $1 == "" && $mpv_exe == "" ]] && ./clang.sh

echo 'Done: ' $(date '+%H:%M:%S') >> $HOME/build_time.txt
