#!/bin/bash

set -x #echo on

add_option () {

	if ! grep -- "$3" toolchain/$1.cmake; then
		sed -i "/$2/a \    $3" toolchain/$1.cmake
	fi
}


cd ~/mpv-winbuild-cmake/


add_option mingw-w64 "GIT_SHALLOW 1" "GIT_TAG v7.0.0"

