#!/bin/bash
clear
echo $0 $@

# some library version may fail during build, find an old version to make it work


cd ~/mpv-winbuild-cmake/

if grep -A1 "enable-javascript" packages/mpv.cmake >/dev/null
then
    sed -i "s/--enable-javascript/--disable-javascript/" packages/mpv.cmake
		echo "JavaScript disabled"
else
    sed -i "s/--disable-javascript/--enable-javascript/" packages/mpv.cmake
		echo "JavaScript enabled"
fi
