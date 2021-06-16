#!/bin/bash
clear
echo $0 $@

add_option () {
	if ! grep -- "$3" packages/$1.cmake; then
		sed -i "/$2/a \        $3" packages/$1.cmake
	fi
}

comment_line () {
	sed -i "/^\s*$2/s/^/#/g" packages/$1
}

cd ~/mpv-winbuild-cmake/

set -x #echo on

#vapoursynth
comment_line ffmpeg.cmake vapoursynth
comment_line ffmpeg.cmake --enable-vapoursynth


#sed -i "/--enable-vapoursynth/d" packages/mpv.cmake
sed -i "s/--enable-vapoursynth/--disable-vapoursynth/" packages/mpv.cmake

#sed -i "s/--enable-pdf-build/--disable-pdf-build/" packages/mpv.cmake
comment_line mpv.cmake "--enable-pdf-build"
sed -i "/manual.pdf/d" packages/mpv.cmake

add_option mpv --enable-static-build --disable-debug-build

comment_line mpv.cmake "--enable-sdl2"

sed -i "s/--enable-javascript/--disable-javascript/" packages/mpv.cmake
