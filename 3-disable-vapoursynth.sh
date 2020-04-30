#!/bin/bash

set -x #echo on

add_option () {

	if ! grep -- "$3" packages/$1.cmake; then
		sed -i "/$2/a \        $3" packages/$1.cmake
	fi
}


cd ~/mpv-winbuild-cmake/

sed -i "/--enable-vapoursynth/d" packages/mpv.cmake
sed -i "s/--enable-pdf-build/--disable-pdf-build/" packages/mpv.cmake
sed -i "/manual.pdf/d" packages/mpv.cmake

add_option mpv --enable-static-build --disable-debug-build

