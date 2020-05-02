#!/bin/bash

# some library version may fail during build, find an old version to make it work

set -x #echo on

add_option () {

	if ! grep -- "$3" $1.cmake; then
		sed -i "/$2/a \    $3" $1.cmake
	fi
}


cd ~/mpv-winbuild-cmake/

#add_option toolchain/mingw-w64 "GIT_SHALLOW 1" "GIT_TAG v7.0.0"
#add_option packages/vulkan "GIT_SHALLOW 1" "GIT_TAG v1.2.135"
#add_option packages/shaderc "shaderc.git" "GIT_TAG v2019.1"
add_option packages/glslang "GIT_SHALLOW 1" "GIT_TAG 8.13.3743"

