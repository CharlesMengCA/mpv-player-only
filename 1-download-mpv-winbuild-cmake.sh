#!/bin/bash
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
source $SCRIPT_DIR/functions.sh

BUILD_DIR="mpv-winbuild-cmake/"

if [[ "$(cat /etc/os-release)" == *"Arch Linux"* ]]; then
  # warning: XXX is up to date -- skipping curl
  # flex automake autoconf pkg-config patch gcc-multilib subversion
  # clang is required by ffmpeg/cuda-llvmc
  sudo pacman -S --noconfirm --needed \
		git gyp mercurial  ninja cmake ragel yasm nasm asciidoc enca \
		gperf unzip p7zip gcc-multilib python-pip clang meson po4a \
      python-mako python-j2cli python-jsonschema mold \
      lld libc++ libc++abi less wget
else
  sudo apt-get update
  sudo apt-get install -y \
		build-essential checkinstall bison flex gettext git mercurial ninja-build \
		gyp cmake yasm nasm automake pkg-config libtool libtool-bin gcc-multilib g++-multilib \
		clang libgmp-dev libmpfr-dev libmpc-dev libgcrypt-dev gperf ragel texinfo autopoint \
		re2c asciidoc python3-pip docbook2x unzip p7zip-full curl meson
fi

#pip3 install mako
# --root-user-action=ignore
#rst2pdf

git config --global user.email "fakeuser@outlook.com"
git config --global user.name "fakeuser"
git config --global http.lowSpeedLimit 1000
git config --global http.lowSpeedTime 120
git config --global pull.rebase true
git config --global fetch.prune true
git config --global --add safe.directory $PWD
git config --global http.postBuffer 157286400

echo_info $0 $@

cd

if [ -d "$BUILD_DIR" ]; then
	cd $BUILD_DIR && rm packages/*

   set -x #echo on
   git reset --hard origin/master && git pull
else
   set -x #echo on

   git clone https://github.com/shinchiro/mpv-winbuild-cmake.git --depth=1
   #git clone https://github.com/Andarwinux/mpv-winbuild-cmake.git --depth=1
   #git clone https://github.com/CharlesMengCA/mpv-winbuild-cmake.git --depth=1
   #git clone -b clang https://github.com/shinchiro/mpv-winbuild-cmake.git --depth=1

   cd $BUILD_DIR

   # use mbedtls
   #git checkout -b cm a9e1712af0eb3cc1d5e926e0ea11d41ec6131ad0

	#git checkout 78767174caf931dbfc1efc12c492caff87d7ab19 packages/freetype2.cmake packages/ft2exec.in
fi

#if ! [[ $1 == "gcc" || $2 == "gcc" ]]; then
   #git am --3way $SCRIPT_DIR/Patch/toolchain_misc.patch
#fi

git am --3way $SCRIPT_DIR/Patch/unity.patch
git am --3way $SCRIPT_DIR/Patch/luajit-malloc.patch
git am --3way $SCRIPT_DIR/Patch/drop_expat.patch

# used to apply customized patches
cp -v --preserve=timestamps $SCRIPT_DIR/Patch/cm-patch.sh ./packages

#git am --3way $SCRIPT_DIR/Patch/package_misc.patch
git log -n 3 --oneline

#export CFLAGS=-fuse-ld=mold
#df -h

{ set +x; } 2>/dev/null # echo off

append_option libva "--buildtype=release" "-Db_ndebug=true"
append_option dav1d "--buildtype=release" "-Db_ndebug=true"
append_option fribidi "--buildtype=release" "-Db_ndebug=true"
append_option harfbuzz "--buildtype=release" "-Db_ndebug=true"
append_option freetype2 "--buildtype=release" "-Db_ndebug=true"
append_option fontconfig "--buildtype=release" "-Db_ndebug=true"
append_option rubberband "--buildtype=release" "-Db_ndebug=true"
