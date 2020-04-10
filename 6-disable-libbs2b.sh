#!/bin/bash

set -x #echo on

comment_line () {

	sed -i "/^\s*$2/s/^/#/g" packages/$1
}


cd ~/mpv-winbuild-cmake/

comment_line CMakeLists.txt libbs2b
comment_line ffmpeg.cmake libbs2b
comment_line ffmpeg.cmake --enable-libbs2b
