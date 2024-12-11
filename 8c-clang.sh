#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $SCRIPT_DIR/functions.sh

echo_info $0 $@
cd ~/mpv-winbuild-cmake/

echo 'Clang start: ' $(date '+%H:%M:%S') >> $HOME/build_time.txt
#set -x #echo on

#mkdir -p cmake/
#tar -xf ~/mpv/Others/modules.tar.gz -C cmake/
#cp -v ~/mpv/Others/modules.tar.gz .

# https://github.com/shinchiro/mpv-winbuild-cmake/blob/master/.github/workflows/llvm_clang.yml

cmake -DCOMPILER_TOOLCHAIN=clang -DTARGET_ARCH=x86_64-w64-mingw32 \
      -DGCC_ARCH=x86-64-v3 \
      -DMINGW_INSTALL_PREFIX=$PWD/build64/x86_64_v3-w64-mingw32 \
      -DCMAKE_INSTALL_PREFIX=$PWD/clang_root \
      -DSINGLE_SOURCE_LOCATION=$PWD/src_packages \
      -DRUSTUP_LOCATION=$PWD/clang_root/install_rustup \
      -G Ninja -Bbuild64 -H. -Wno-dev 

cd build64

#until git ls-remote https://github.com/facebook/zstd.git HEAD >/dev/null
#do
#   sleep 0.5
#done

#until [ -f $HOME/mpv-winbuild-cmake/src_packages/zstd-host/Makefile ]
#do
#  echo_build zstd-host
#done

#until [ -f $HOME/mpv-winbuild-cmake/src_packages/zlib-host/configure ]
#do
#  echo_build zlib-host
#done

#until [ -f $HOME/mpv-winbuild-cmake/src_packages/mimalloc/CMakeLists.txt ]
#do
#  echo_build mimalloc
#done

echo_build llvm
echo_build llvm-clang
[ $? -ne 0 ] && exit 1

echo_build rustup

{ set +x; } 2>/dev/null # echo off
echo 'Clang end: ' $(date '+%H:%M:%S') >> $HOME/build_time.txt

cd ..

cmake -DCOMPILER_TOOLCHAIN=clang -DTARGET_ARCH=x86_64-w64-mingw32 \
      -DGCC_ARCH=x86-64-v3 \
      -DMINGW_INSTALL_PREFIX=$PWD/build64/x86_64_v3-w64-mingw32 \
      -DCMAKE_INSTALL_PREFIX=$PWD/clang_root \
      -DSINGLE_SOURCE_LOCATION=$PWD/src_packages \
      -DRUSTUP_LOCATION=$PWD/clang_root/install_rustup \
      -DCLANG_FLAGS="-fdata-sections -ffunction-sections" \
      -DLLD_FLAGS="-O3 --gc-sections -Xlink=-opt:safeicf" \
      -G Ninja -B build64 -H. -Wno-dev 

if [[ $1 == "backup" ]]; then
   cd
   tar cf - mpv-winbuild-cmake/ | 7z a -si -mx9 "mpv/Patch/llvm_"$(date '+%y%m%d_%H%M')".tar.7z"
   echo 'Compiler cached: ' $(date '+%H:%M:%S') >> $HOME/build_time.txt
fi

#      -DCLANG_FLAGS="-fdata-sections -ffunction-sections -faddrsig" \
#      -DLLD_FLAGS="-O3 --gc-sections --icf=all" \
