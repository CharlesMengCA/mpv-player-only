#!/bin/bash
clear
echo $0 $@

BUILD64=~/mpv-winbuild-cmake/build64

cd $BUILD64

set -x #echo on

#cmake -DTARGET_ARCH=x86_64-w64-mingw32 -G Ninja ..

ninja update

ninja vulkan

FILE=$BUILD64/install/x86_64-w64-mingw32/lib/pkgconfig/vulkan.pc
if [ ! -f "$FILE" ]; then

		sed -i "s/if(PKG_CONFIG_FOUND)/if(TRUE)/" $BUILD64/packages/vulkan-prefix/src/vulkan/loader/CMakeLists.txt

		rm $BUILD64/packages/vulkan-prefix/src/vulkan-stamp/vulkan-build

		ninja vulkan
fi

ninja glslang

ninja x264 shaderc gmp speex vorbis xvidcore lzo expat

ninja mujs

ninja libssh

ninja mpv

