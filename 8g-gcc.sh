#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $SCRIPT_DIR/functions.sh

echo_info $0 $@
cd ~/mpv-winbuild-cmake/

echo 'gcc start: ' $(date '+%H:%M:%S') >> $HOME/build_time.txt
set -x #echo on

#replace_option mpv "-Dc_args='-Wno-error=int-conversion'" "-Dc_args='-Wno-error=int-conversion,-Wno-stringop-overflow'"

#mkdir -p cmake/
#tar -xf ~/mpv/Others/modules.tar.gz -C cmake/
#cp -v ~/mpv/Others/modules.tar.gz .

cmake -DTARGET_ARCH=x86_64-w64-mingw32 \
      -DGCC_ARCH=x86-64-v3 \
      -DSINGLE_SOURCE_LOCATION=$PWD/src_packages \
      -DRUSTUP_LOCATION=$PWD/install_rustup \
      -G Ninja -Bbuild64 -H.

cd build64

ninja gcc rustup

echo 'gcc end: ' $(date '+%H:%M:%S') >> $HOME/build_time.txt

#{ set +x; } 2>/dev/null # echo off
#cd
#tar cf - mpv-winbuild-cmake/ | 7z a -si -mx9 "mpv/Patch/gcc_"$(date '+%y%m%d_%H%M')".tar.7z"
