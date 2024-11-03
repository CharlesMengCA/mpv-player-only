#!/bin/bash
rm -rf $HOME/mpv-winbuild-cmake/

./updateSystem.sh
echo 'Start: ' $(date '+%H:%M:%S') > $HOME/build_time.txt
sudo pacman -S --noconfirm --needed p7zip

echo -e '\nRestoring pre-built llvm...'
7z x -so Patch/llvm.tar.7z | tar xf - -C ~

./1-download-mpv-winbuild-cmake.sh $1
./2-disable-ffmpeg-encoder.sh "all"

[[ $1 == "2" || $2 == "2" ]] && exit

if ! [[ $1 == "jxl" || $2 == "jxl" ]]; then
   ./disable-ffmpeg-jxl.sh
fi

if [[ $1 == "js" || $2 == "js" ]]; then
   ./toggleJS.sh "on"
else
   ./toggleJS.sh "off"
fi

./3-disable-vapoursynth.sh
./4-use-old-version.sh
./5-disable-OpenGL.sh
./6-disable-libbs2b.sh
./7-new-toolchain.sh

[[ $1 == "8" ]] && exit
[[ $2 == "8" ]] && exit

./9b-build-mpv.sh

mpv_exe=$(find ~/mpv-winbuild-cmake/build64 -name mpv.exe)

[[ $1 == "" && $mpv_exe == "" ]] && ./clang.sh

echo 'Done: ' $(date '+%H:%M:%S') >> $HOME/build_time.txt
