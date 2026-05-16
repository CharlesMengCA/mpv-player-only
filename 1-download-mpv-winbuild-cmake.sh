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
		gperf unzip p7zip gcc-multilib python-pip clang  po4a \
      python-mako python-j2cli python-jsonschema mold \
      lld libc++ libc++abi less wget meson
else
  sudo apt-get update
  sudo apt-get install -y \
		build-essential checkinstall bison flex gettext git mercurial ninja-build \
		gyp cmake yasm nasm automake pkg-config libtool libtool-bin gcc-multilib g++-multilib \
		clang libgmp-dev libmpfr-dev libmpc-dev libgcrypt-dev gperf ragel texinfo autopoint \
		re2c asciidoc python3-pip docbook2x unzip p7zip-full curl meson
fi

#meson
#sudo pacman -U --needed --noconfirm https://archive.archlinux.org/repos/2025/11/21/extra/os/x86_64/meson-1.9.1-2-any.pkg.tar.zst

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

{ set +x; } 2>/dev/null # echo off

if [[ $1 == "a" || $2 == "a" ]]; then
   git am --3way $SCRIPT_DIR/Patch/747.patch   
   replace_option llvm-ld.in " --file-alignment=4096" ""
else
   git am --3way $SCRIPT_DIR/Patch/unity.patch
   git am --3way $SCRIPT_DIR/Patch/drop_expat.patch
   git am --3way $SCRIPT_DIR/Patch/749.patch

   git am --3way $SCRIPT_DIR/Patch/luajit-malloc.patch
fi

# used to apply customized patches
cp -v --preserve=timestamps $SCRIPT_DIR/Patch/cm-patch.sh ./packages

#git am --3way $SCRIPT_DIR/Patch/package_misc.patch
git log -n 3 --oneline

#export CFLAGS=-fuse-ld=mold
#df -h

append_option libva "--buildtype=release" "-Db_ndebug=true"
append_option dav1d "--buildtype=release" "-Db_ndebug=true"
append_option fribidi "--buildtype=release" "-Db_ndebug=true"
append_option harfbuzz "--buildtype=release" "-Db_ndebug=true"
append_option freetype2 "--buildtype=release" "-Db_ndebug=true"
append_option fontconfig "--buildtype=release" "-Db_ndebug=true"
append_option rubberband "--buildtype=release" "-Db_ndebug=true"

if [[ $1 == "a" || $2 == "a" ]]; then
   replace_option mpv "--depth=1 " ""
   #comment_line mpv "-Dlibmpv=false"
   #comment_line mpv "-Dcplayer=true"
   append_option mpv "--prefer-static" "-Doptimization=3"
   append_option mpv "--prefer-static" "-Db_ndebug=true"

   replace_option libass "--depth=1 --no-single-branch " ""
   replace_option ffmpeg "<SOURCE_DIR>\/libass\/x86" "<SOURCE_DIR>\/\.\.\/libass\/libass\/x86"

   comment_line CMakeLists.txt "liblc3"
   comment_line ffmpeg "liblc3"
   comment_line ffmpeg "--enable-liblc3"

   comment_line CMakeLists.txt "opencl"
   comment_line ffmpeg "opencl"
   comment_line ffmpeg "--enable-opencl"

   comment_line CMakeLists.txt "libvidstab"
   comment_line ffmpeg "libvidstab"
   comment_line ffmpeg "--enable-libvidstab"

   comment_line CMakeLists.txt "frei0r"
   comment_line ffmpeg "frei0r"
   comment_line ffmpeg "--enable-frei0r"

   comment_line CMakeLists.txt "vvenc"
   comment_line ffmpeg "vvenc"
   comment_line ffmpeg "--enable-libvvenc"

   comment_line CMakeLists.txt "codec2"
   comment_line ffmpeg "codec2"
   comment_line ffmpeg "--enable-libcodec2"
else
   #ffmpeg: re-enable hardcoded tables
   #The culprit that broke hardcoded tables build was aac_fixed, and since current x86 baseline requires SSE2, we don't need slow fixed-point decoder, disable it will fix hardcoded tables build
   append_option ffmpeg "--enable-runtime-cpudetect" "--enable-hardcoded-tables"
   replace_option ffmpeg "--disable-decoder=libaom_av1" "--disable-decoder=libaom_av1,aac_fixed,ac3_fixed"
fi