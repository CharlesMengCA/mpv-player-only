#!/bin/bash
clear && echo $0 $@

cd ~/mpv-winbuild-cmake/

StartTime=$(date '+%H:%M:%S')
set -x #echo on

#mkdir -p cmake/
#tar -xf ~/mpv/Others/modules.tar.gz -C cmake/
#cp -v ~/mpv/Others/modules.tar.gz .

cmake -DTARGET_ARCH=x86_64-w64-mingw32 \
      -DCOMPILER_TOOLCHAIN=clang -DALWAYS_REMOVE_BUILDFILES=ON \
      -DCMAKE_INSTALL_PREFIX=$PWD/clang_root \
      -DSINGLE_SOURCE_LOCATION=$PWD/src_packages \
      -DRUSTUP_LOCATION=$PWD/install_rustup \
      -G Ninja -Bbuild64 -H.

cd build64

ninja llvm
ninja llvm-clang
ninja rustup

{ set +x; } 2>/dev/null # echo off
echo 'Build:' $StartTime '->' $(date '+%H:%M:%S')