#!/bin/bash
source $(pwd)/functions.sh

StartTime=$(date '+%H:%M:%S')

clear && echo $0 $@

cd ~/mpv-winbuild-cmake/build64/packages/

rm -r spirv-cross-prefix
rm -r libssh-prefix
rm -r nettle-prefix
rm -r luajit-prefix
rm -r fontconfig-prefix
rm -r lame-prefix
rm -r mujs-prefix
rm -r vulkan-prefix
rm -r libsrt-prefix
rm -r ffmpeg-prefix
rm -r mpv-prefix
rm -r libjxl-prefix
rm -r libbluray-prefix

#rm -r libbs2b-prefix
#rm -r libepoxy-prefix
#rm -r libmodplug-prefix

cd ..
ninja mpv

echo 'Build:' $StartTime '->' $(date '+%H:%M:%S')