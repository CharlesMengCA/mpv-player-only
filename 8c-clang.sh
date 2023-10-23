#!/bin/bash
clear && echo $0 $@
cd ~/mpv-winbuild-cmake/

echo 'Clang start: ' $(date '+%H:%M:%S') >> $HOME/build_time.txt
set -x #echo on

#mkdir -p cmake/
#tar -xf ~/mpv/Others/modules.tar.gz -C cmake/
#cp -v ~/mpv/Others/modules.tar.gz .

cmake -DCOMPILER_TOOLCHAIN=clang -DTARGET_ARCH=x86_64-w64-mingw32 \
      -DGCC_ARCH=x86-64-v3 \
      -DCMAKE_INSTALL_PREFIX=$PWD/clang_root \
      -DSINGLE_SOURCE_LOCATION=$PWD/src_packages \
      -DRUSTUP_LOCATION=$PWD/install_rustup \
      -G Ninja -Bbuild64 -H.

cd build64

ninja llvm
ninja llvm-clang
[ $? -ne 0 ] && exit 1

ninja rustup

{ set +x; } 2>/dev/null # echo off
echo 'Clang end: ' $(date '+%H:%M:%S') >> $HOME/build_time.txt

cd ..

cmake -DCOMPILER_TOOLCHAIN=clang -DTARGET_ARCH=x86_64-w64-mingw32 \
      -DGCC_ARCH=x86-64-v3 \
      -DCMAKE_INSTALL_PREFIX=$PWD/clang_root \
      -DSINGLE_SOURCE_LOCATION=$PWD/src_packages \
      -DRUSTUP_LOCATION=$PWD/install_rustup \
      -DCLANG_FLAGS="-fdata-sections -ffunction-sections" \
      -DLLD_FLAGS="-O3 --gc-sections" \
      -G Ninja -Bbuild64 -H.

cd
tar cf - mpv-winbuild-cmake/ | 7z a -si -mx9 "mpv/Patch/llvm_"$(date '+%y%m%d_%H%M')".tar.7z"
echo 'Compiler cached: ' $(date '+%H:%M:%S') >> $HOME/build_time.txt

