#!/bin/bash

set -x #echo on

add_option () {

	if ! grep -- "$3" packages/$1.cmake; then
		sed -i "/$2/a \    $3" packages/$1.cmake
	fi
}


cd ~/mpv-winbuild-cmake/


add_option vulkan "GIT_SHALLOW 1" "GIT_TAG v1.2.135"

