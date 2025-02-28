#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source $SCRIPT_DIR/functions.sh

sudo pacman -S --noconfirm --needed \
   git gyp mercurial  ninja cmake ragel yasm nasm asciidoc enca \
   gperf unzip p7zip gcc-multilib python-pip clang meson po4a \
   python-mako python-j2cli python-jsonschema mold \
   lld libc++ libc++abi less wget

git config --global user.email "fakeuser@outlook.com"
git config --global user.name "fakeuser"
git config --global http.lowSpeedLimit 1000
git config --global http.lowSpeedTime 120
git config --global pull.rebase true
git config --global fetch.prune true
git config --global --add safe.directory $PWD
git config --global http.postBuffer 157286400

cd 

rm -rf mpv-winbuild-cmake/

if [[ $1 == "a" || $1 == "all" ]]; then
   git clone https://github.com/shinchiro/mpv-winbuild-cmake.git --depth=1
   cd mpv-winbuild-cmake   
else
   echo -e '\nRestoring pre-built llvm...'
   7z x -so mpv/Patch/llvm.tar.7z | tar xf - -C ~

   cd mpv-winbuild-cmake

   git reset --hard origin/master && git pull
fi

#mpv manual.pdf
replace_option mpv "-Dpdf-build=enabled" "-Dpdf-build=disabled"
delete_line mpv "manual.pdf"
append_option mpv "-Dpdf-build=disabled" "-Dmanpage-build=disabled"

cmake -DCOMPILER_TOOLCHAIN=clang -DTARGET_ARCH=x86_64-w64-mingw32 \
      -DGCC_ARCH=x86-64-v3 \
      -DCMAKE_INSTALL_PREFIX=$PWD/clang_root \
      -DSINGLE_SOURCE_LOCATION=$PWD/src_packages \
      -DRUSTUP_LOCATION=$PWD/install_rustup \
      -G Ninja -Bbuild64 -H.

cd build64

if [[ $1 == "a" || $1 == "all" ]]; then
   ninja llvm
   ninja rustup
   ninja llvm-clang 
fi

ninja mpv