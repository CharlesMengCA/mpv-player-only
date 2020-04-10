#!/bin/bash

set -x #echo on

add_option () {

	if ! grep -- "$3" packages/$1.cmake; then
		sed -i "/$2/a \        $3" packages/$1.cmake
	fi
}

cd ~/mpv-winbuild-cmake/

add_option ffmpeg -pkg-config-flags=--static --disable-programs
add_option ffmpeg -pkg-config-flags=--static --disable-doc
add_option ffmpeg -pkg-config-flags=--static --disable-debug
add_option ffmpeg -pkg-config-flags=--static --disable-encoders
 



