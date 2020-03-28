#!/bin/bash

set -x #echo on

add_ffmpeg_option () {

	if ! grep -- "$1" packages/ffmpeg.cmake; then
		sed -i "/-pkg-config-flags=--static/a \        $1" packages/ffmpeg.cmake
	fi
}

cd ~

sudo pacman -S --noconfirm --needed flex git gyp automake autoconf pkg-config patch mercurial subversion ninja cmake meson ragel yasm nasm asciidoc enca gperf unzip p7zip gcc-multilib python2-pip python-docutils python2-lxml python2-pillow curl

git config --global user.email "charlesmeng@outlook.com"
git config --global user.name "charlesmeng"

git clone https://github.com/shinchiro/mpv-winbuild-cmake.git

cd mpv-winbuild-cmake/

add_ffmpeg_option "--disable-programs" 
add_ffmpeg_option "--disable-doc" 
add_ffmpeg_option "--disable-debug" 
add_ffmpeg_option "--disable-encoders"
 
sed -i "/--enable-vapoursynth/d" packages/mpv.cmake

mkdir build64
cd build64

cmake -DTARGET_ARCH=x86_64-w64-mingw32 -G Ninja ..

ninja gcc

ninja x264 vulkan shaderc gmp libmodplug speex vorbis xvidcore lzo expat

ninja mpv



