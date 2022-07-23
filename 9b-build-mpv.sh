#!/bin/bash
clear && echo $0 $@

BUILD64=~/mpv-winbuild-cmake/build64
cd $BUILD64

StartTime=$(date '+%H:%M:%S')
set -x #echo on

ninja vulkan

#FILE=$BUILD64/install/x86_64-w64-mingw32/lib/pkgconfig/vulkan.pc
#if [ ! -f "$FILE" ]; then

#		sed -i "s/if(PKG_CONFIG_FOUND)/if(TRUE)/" $BUILD64/packages/vulkan-prefix/src/vulkan/loader/CMakeLists.txt

#		rm $BUILD64/packages/vulkan-prefix/src/vulkan-stamp/vulkan-build

#		ninja vulkan
#fi

ninja shaderc

#FILE=$BUILD64/install/x86_64-w64-mingw32/lib/pkgconfig/shaderc.pc

#if [ ! -f "$FILE" ]; then
#	cp $BUILD64/packages/shaderc-prefix/src/shaderc-build/shaderc.pc $FILE
#fi

ninja libplacebo

#rm $FILE

ninja spirv-cross
ninja libarchive
ninja libass
#ninja harfbuzz
ninja libjxl

ninja mpv

{ set +x; } 2>/dev/null # echo off

cd mpv-x86_64* && ls -g -o --time-style=iso *.exe
cd ../mpv-dev-x86_64-* && ls -g -o --time-style=iso *.dll

echo 'Build:' $StartTime '->' $(date '+%H:%M:%S')
